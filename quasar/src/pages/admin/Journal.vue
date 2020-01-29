<template>
    <q-layout>
        <q-page padding id="journal">

            <h5 class="title">Список пользователей</h5>
            <div class="date">
                <span>Выберите дату:</span>

                <div class="from">
                    <span>с:</span>
                    <q-datetime format="DD.MM.YYYY"
                                type="date"
                                class="datetime"
                                v-model="from"
                                hide-underline
                                @change="datesArray()"
                                :max="to"
                    />
                </div>
                <div class="to">
                    <span>по:</span>
                    <q-datetime format="DD.MM.YYYY"
                                type="date"
                                class="datetime"
                                v-model="to"
                                hide-underline
                                @change="datesArray()"
                                :min="from"
                    />
                </div>
            </div>

            <ul class="table">
                <li class="left">
                    <ul>
                        <li class="tr thead"> <!-- строки -->
                            <ul class="head">
                                <li class="id td"> <!-- ячейки -->
                                    <span>id</span>
                                </li>
                                <li class="name td">
                                    <span>ФИО</span>
                                </li>
                            </ul>
                        </li>
                        <li class="tr tbody" v-for="user in users"> <!-- строки -->
                            <ul class="body">
                                <li class="id td"> <!-- ячейки -->
                                    <span>{{user.id}}</span>
                                </li>
                                <li class="name td">
                                    <span>{{user.name}}</span>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </li>
                <li class="right">
                    <ul class="head">
                        <li class="columns" v-for="key in dates"> <!-- колонки -->
                            <span class="day">{{key.format('dd')}}</span>
                            <span class="month">{{key.format('mm')}}</span>
                        </li>
                    </ul>
                    <ul class="body" v-for="user in users">
                        <li class="td" v-for="key in dates"
                            :title="showMessage(user, key)"
                            @click="showAbsencePopup(user, key)"
                        >
                            <span>{{absenceReasonToCell(user, key) ?
                            absenceReasonToCell(user, key).reason.shortName:''}}</span>
                        </li>
                    </ul>
                </li>
            </ul>

            <absence-popup ref="absenceOpen"/>
        </q-page>
    </q-layout>
</template>

<script>
    import store from '../../store/admin'
    import { mapGetters } from 'vuex'
    import DateFormat from '../../assets/js/dateFormat'
    import AbsencePopup from '../../components/admin/absence-popup'

    export default {
        store,
        components: {AbsencePopup},
        data() {
            return {
                from: new Date(new Date().setDate(1)),
                to: new Date(new Date().getFullYear(), new Date().getMonth()+1, 0),
                dates: [] //массив хранит даты (с/по)
            }
        },
        mounted() {
            document.querySelector('#journal .from .q-if-control').innerText = '';
            document.querySelector('#journal .to .q-if-control').innerText = '';

            store.dispatch('axiosUsers');
            store.dispatch('axiosReasons');
            store.dispatch('axiosAbsences');

            //заполнение таблицы датами с и по
            this.datesArray();
        },
        methods: {
            datesArray: function () {

                //обнулить массив дат перед добавлением
                this.dates.length = 0;

                //устанавливаем время в 0 и возвращаем формат с мс на дату
                let from = new Date(this.from.setHours(0,0,0,0));
                let to = new Date(this.to.setHours(0,0,0,0));
                let diff = Math.ceil((to - from)/8.64e+7); //разница в днях


                //дабвить день from
                this.dates.push(
                    new Date( from.setDate( from.getDate() ) )
                );

                //добавить остальные дни
                for (let i = 0; i < diff; i++) {

                    this.dates.push(
                        new Date( from.setDate( from.getDate()+1 ) )
                    );
                }
            },
            absenceReasonToCell(user, date) {

                for (let key in this.absences) {

                    //это причина этого пользователя
                    if (Number(this.absences[key].user_id) === Number(user.id)) {

                        //это диапазон дат
                        if (this.absences[key].from && this.absences[key].to) {

                            //пришедшая дата лежит в диапазон дат причины
                            if (date >= new Date(this.absences[key].from).setHours(0,0,0,0) &&
                                date <= new Date(this.absences[key].to).setHours(0,0,0,0)) {

                                //нужно вернуть букву типа причины
                                for (let jey in this.reasons) {
                                    if (Number(this.reasons[jey].id) === Number(this.absences[key].reason_id)) {

                                        return {reason: this.reasons[jey], absence: this.absences[key]};
                                    }
                                }
                            }

                        //это не диапазон
                        } else if (date.format('yyyy-mm-dd') === this.absences[key].from) {

                            //нужно вернуть букву типа причины
                            for (let jey in this.reasons) {
                                if (Number(this.reasons[jey].id) === Number(this.absences[key].reason_id)) {

                                    return {reason: this.reasons[jey], absence: this.absences[key]};
                                }
                            }
                        }
                    }
                }
            },
            showAbsencePopup(user, date) {
                this.$refs.absenceOpen.absenceOpen(user, date, this.absenceReasonToCell(user, date));
            },
            showMessage(user, key) {

                return this.absenceReasonToCell(user, key) ?
                    this.absenceReasonToCell(user, key).absence.massage:''
            }
        },
        computed: {
            ...mapGetters({
                users: 'getUsers',
                reasons:'getReasons',
                absences: 'getAbsences'
            })
        }
    }
</script>

<style>
    /*ТАБЛИЦА*/
    #journal .table {
        float: left;
        display: flex;
        border: 1px solid #d6d6d8;
        color: #555555;
        position: relative;

        max-height: 60vh;
        max-width: calc(100% - 0.1%);
        overflow: scroll;
    }

    #journal .table .left .head {
        border-right: 1px solid #d6d6d8;
    }
    #journal .table .head {
        display: flex;
        justify-content: flex-start;
        align-items: center;
        height: 56px;
        box-sizing: border-box;
    }

    #journal .table .left { /*вертикальное*/
        position: sticky;
        left: 0;
        z-index: 2;
    }
    #journal .table .left .thead,
    #journal .table .right .head { /*горизонтальное*/
        position: sticky;
        top: 0;
        z-index: 1;
    }

    #journal .table .left .tr {
        border-bottom: 1px solid #d6d6d8;
        background-color: #ececec; /*подсветка шапки слева*/
    }
    #journal .table .left .tr:last-child {
        height: 29px;
    }
    #journal .table .left .tbody { /*лево, боди*/
        display: flex;
        justify-content: center;
        align-items: center;
        height: 30px;
        box-sizing: border-box;
    }
    #journal .table .right .body {
        transition: 0.1s;
    }
    #journal .table .right .body:hover {
        background-color: #fff;
    }
    #journal .table .right .body .td {
        cursor: pointer;
        transition: 0.1s;
    }
    #journal .table .right .body .td:hover {
        box-shadow: inset 0 0 8px #6E6E6E;
    }
    #journal .table .right .body .td:active {
        box-shadow: inset 0 0 15px #696969;
    }
    #journal .table .left .head .id,
    #journal .table .left .head .name {
        height: 100%;
    }
    #journal .table .left .head .id span {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100%;
        min-width: 30px;
    }
    #journal .table .left .head .name span {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100%;
        min-width: 250px;
    }

    #journal .table .head .id,
    #journal .table .body .id {
        border-right: 1px solid #d6d6d8;
    }
    #journal .table .left .tbody {
        display: flex;
        justify-content: flex-start;
        align-items: center;
        border-right: 1px solid #d6d6d8;
    }
    #journal .table .left .tbody .id span {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100%;
        min-width: 30px;

    }
    #journal .table .left .tbody .name {
        padding: 5px;
    }
    #journal .table .left .tbody .name span {
        display: flex;
        align-items: center;
        justify-content: center;
        white-space: nowrap;
    }
    #journal .table .head .name {

    }
    #journal .table .head .name,
    #journal .table .body .name {

    }
    #journal .table .body {
        display: flex;
    }
    #journal .table .body .id span {

    }
    #journal .table .body .name span {

    }
    #journal .table .right .head {

    }
    #journal .table .right .head .columns:first-child {
        border-left: none;
    }
    #journal .table .right .head .columns:last-child {
        border-right: 1px solid #d6d6d8;
    }

    #journal .table .right .head .columns {
        border-left: 1px solid #d6d6d8;
        float: left;
        min-width: 30px;
        border-bottom: 1px solid #d6d6d8;
        background-color: #e6e6e6;
    }
    #journal .table .right .head .columns .day {
        border-bottom: 1px solid #d6d6d8;
    }
    #journal .table .right .head .columns .month {
    }
    #journal .table .right .head .columns .day,
    #journal .table .right .head .columns .month {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 28px;
    }

    #journal .table .right .body:last-child .td {
        border-bottom: 1px solid #d6d6d8;
    }
    #journal .table .right .td {
        min-width: 30px;
        min-height: 30px;
        display: flex;
        justify-content: center;
        align-items: center;
        border: 1px solid #d6d6d8;
        border-bottom: none;
        border-right: none;
    }
    #journal .table .right .td:first-child {
        border-left: none;
    }
    #journal .table .right .td:last-child {
        border-right: 1px solid #d6d6d8;
    }


    /*ТАБЛИЦА*/
    #journal {
        width: 100%;
    }
    #journal .title {
        padding: 0;
        margin: 0 0 20px 0;
        text-align: center;
        font-style: normal;
        font-weight: bold;
        font-size: 16px;
        line-height: 29px;
        color: #0C4CBC;
    }
    #journal .date { /*блок с датами*/
        color: #0C4CBC;
        font-size: 16px;
        font-weight: bold;
        display: flex;
        align-items: center;
        width: 100%;
        margin-bottom: 25px;
    }
    #journal .date .datetime {
        border: 1px solid #043DA0;
        border-radius: 5px;
        padding: 0 0 0 10px;
        width: 110px;
        margin: 0 5px; /*отстут от "с" и "по" до datapicker*/
        height: 20px;
    }
    #journal .date .datetime:hover {
        background-color: #eeeaea;
    }
    #journal .date .q-input-target {
        font-style: normal;
        font-weight: normal;
        font-size: 13px;
        color: #0C4CBC;
        margin: 0;
    }
    #journal .q-if-control {
        background: url("../../statics/icons/datetime-calendar.svg") no-repeat 5px 6px;
        background-size: 12px;
    }
    #journal .date .from,
    #journal .date .to {
        display: flex;
        align-items: center;
    }
    #journal .date .from {
        margin: 0 50px 0 50px;
    }
</style>