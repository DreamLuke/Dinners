<template>
    <div class="overlay">
        <div class="popup">
            <div class="head">
                <h4 class="titlePopup">{{title.label}}</h4>
                <img src="../../statics/icons/close.svg" @click="absenceClose">
            </div>
            <div class="body">

                <q-datetime format="DD.MM.YYYY"
                            type="date"
                            class="absenceDatePopup from"
                            v-model="fields.from.value"
                            hide-underline
                            placeholder="От"
                            :class="fields.from.error"
                            v-on:input="unlockBtn"
                            :max="fields.to.value"
                />
                <q-datetime format="DD.MM.YYYY"
                            type="date"
                            class="absenceDatePopup to"
                            v-model="fields.to.value"
                            hide-underline
                            placeholder="Дата"
                            :class="fields.to.error"
                            v-on:input="unlockBtn"
                            :min="fields.from.value"
                />

                <q-input v-model="fio"
                         color="grey-3"
                         inverted-light
                         placeholder="ФИО"
                         class="shadow-0"
                         :class="fio"
                         readonly
                />
                
                <!--кастомный слект-->
                <custom-select-absence :reasons="reasons"
                                       :defaultType="fields.absenceType.value"
                                       :validation="fields.absenceType.error"
                                       @getType="setType"
                />


                <textarea :class="fields.absenceText.error"
                          v-model="fields.absenceText.value"
                          placeholder="Введите причину отсутствия"
                          v-on:input="unlockBtn"
                />

                <q-btn class="shadow-0"
                       v-if="fields.absenceType.value"
                       label="Удалить причину"
                       size="md"
                       text-color="white"
                       rounded
                       flat
                       no-ripple
                       @click="deleteReason()"
                       id="deleteReason"
                />
                <q-btn class="shadow-0"
                       label="Сохранить"
                       size="md"
                       text-color="white"
                       rounded
                       flat
                       no-ripple
                       @click="save()"
                       id="journalSave"
                />

            </div>
        </div>
    </div>
</template>

<script>
    import CustomSelectAbsence from '../../components/admin/custom-select-absence'
    import store from '../../store/admin'
    import { mapGetters } from 'vuex'
    import axios from 'axios'

    export default {
        store,
        name: 'absence-popup',
        components: {CustomSelectAbsence},
        data() {
            return {
                title: {label: '', value: ''},
                id: '',
                absence_id: '',
                fio: '',
                fields: {
                    from: {
                        value: '',
                        error: '',
                        pattern: /^([^<>]{0,})$/
                    },
                    to: {
                        value: '',
                        error: '',
                        pattern: /^([^<>]{0,})$/
                    },
                    absenceType: {
                        value: '',
                        error: '',
                        pattern: /^([0-9]{1,11})$/
                    },
                    absenceText: {
                        value: '',
                        error: '',
                        pattern: /^([^a-zA-Z<>]+)$/
                    },
                },
            }
        },
        mounted() {
            document.querySelector('.popup .from .q-if-control').innerText = '';
            document.querySelector('.popup .to .q-if-control').innerText = '';
        },
        methods: {
            absenceOpen(user, date, userValues) {

                this.id = user.id;
                this.fio = user.name;
                this.fields.from.value = date;

                if (userValues) {
                    this.fields.absenceType.value = Number(userValues.absence.reason_id);
                    this.fields.absenceText.value = userValues.absence.massage;
                    this.absence_id = Number(userValues.absence.id);

                    this.title.label = 'Редактирование причины';
                    this.title.value = 1;
                } else {
                    this.title.label = 'Добавление причины';
                    this.title.value = 0;
                }

                this.$el.style.display = 'block';

                //блокирую кнопку - можно разблокировать только после изменений
                document.querySelector('#journalSave').setAttribute('disabled', 'disabled');
            },
            absenceClose() {

                //по закрытии обнуляю значения модалки
                for (let key in this.fields) {

                    this.fields[key].value = '';
                    this.fields[key].error = '';
                }

                //закрыть селект
                document.querySelector('.select ul').style = 'max-height: 0px';

                //обнуляю селект
                this.$children[3].add = false;
                this.$children[3].edit = false;
                this.$children[3].added.short.value = '';
                this.$children[3].added.label.value = '';
                this.$children[3].editable.label.value = '';
                this.$children[3].editable.short.value = '';
                this.$children[3].id = '';

                // обнуляю title
                this.title.label = '';
                this.title.value = '';

                //закрыть модалку
                this.$el.style.display = 'none';
            },
            save() {

                let errors = 0;
                for (let key in this.fields) {

                    if (!this.fields[key].pattern.test(this.fields[key].value)) {
                        this.fields[key].error = 'wrongInput';
                        errors++;
                    } else {
                        this.fields[key].error = '';
                    }
                }

                //нет ошибок
                if (!errors) {

                    //это редактирование
                    if (this.title.value) {


                        axios.patch('/journal/update', {
                            user_id: this.id,
                            id: this.absence_id,
                            from: new Date(this.fields.from.value).format('yyyy-mm-dd'),
                            to: this.fields.to.value ? new Date(this.fields.to.value).format('yyyy-mm-dd'):null,
                            reason_id: this.fields.absenceType.value,
                            massage: this.fields.absenceText.value
                        })
                            .then(response => {

                                //сбросить значение модалки
                                for (let key in this.fields) {

                                    this.fields[key].value = '';
                                    this.fields[key].error = '';
                                }

                                //закрыть модалку
                                this.$el.style.display = 'none';

                                //обновить данные
                                store.dispatch('axiosAbsences');
                            })
                            .catch(error => {
                                console.error(error);
                            })

                    } else {

                        //это создание
                        axios.post('/journal/create', {
                            user_id: this.id,
                            from: new Date(this.fields.from.value).format('yyyy-mm-dd'),
                            to: this.fields.to.value ? new Date(this.fields.to.value).format('yyyy-mm-dd'):null,
                            reason_id: this.fields.absenceType.value,
                            massage: this.fields.absenceText.value
                        })
                            .then(response => {

                                this.absenceClose();

                                //обновить данные
                                store.dispatch('axiosAbsences');
                            })
                            .catch(error => {
                                console.error(error);
                            })

                    }

                } else {
                    console.log('ошибки');
                }
            },
            deleteReason() {

                axios.delete('/journal/destroy', {params: {id: 1}})
                    .then(response => {

                        console.log(response);
                    })
                    .catch(error => {
                        console.error(error);
                    })
            },
            setType(data) {
                this.fields.absenceType.value = Number(data);
                this.unlockBtn();
            },
            unlockBtn() {
                document.querySelector('#journalSave').removeAttribute('disabled', 'disabled');
            }
        },
        computed: {
            ...mapGetters({
                reasons:'getReasons',
            })
        }
    }
</script>

<style scoped>
    .wrongInput {
        box-shadow: inset 0 0 3px red !important;
    }
    .overlay {
        position: fixed;
        left: 0;
        top: 0;
        background-color: transparent;
        width: 100%;
        height: 100%;
        display: none;
        z-index: 5;
    }
    .popup {
        position: relative;
        width: auto;
        min-width: 330px;
        max-width: 580px;
        height: 300px;
        margin: 0 auto;
        top: 35vh;
        /*overflow: hidden;*/
        border: 1px solid #043DA0;
        box-shadow: 0 4px 4px rgba(0, 0, 0, 0.25), 0 4px 4px rgba(0, 0, 0, 0.25);
    }
    .popup .head {
        position: absolute;
        height: 38px;
        width: 100.1%;
        background-color: #136598;
        padding: 0 10px 0 18px;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }
    .popup .titlePopup {
        padding: 0;
        margin: 0;
        font-style: normal;
        font-weight: bold;
        font-size: 18px;
        line-height: 29px;
        color: #FFFFFF;
    }
    .popup .head img {
        cursor: pointer;
    }
    .popup .body {
        position: absolute;
        top: 38px;
        left: 0;
        width: 100%;
        height: 87.3%;
        padding: 25px 20px 15px 20px;
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        grid-template-rows: repeat(5, 1fr);
        grid-column-gap: 10px;
        grid-row-gap: 10px;
        background-color: #fff;
    }
    .popup .body .absenceDatePopup {
        background: #eeeeee;
        border-radius: 5px;
        font-size: 12px;
    }
    .popup .from {
        grid-column: 1/3;
        grid-row: 1/2;
    }
    .popup .to {
        grid-column: 3/5;
        grid-row: 1/2;
    }
    .popup .q-input {
        font-size: 12px;
        grid-column: 3/5;
        grid-row: 2/3;
    }
    .popup .body .select {
        grid-column: 1/3;
        grid-row: 2/3;
    }
    .popup .body textarea {
        background-color: #eeeeee;
        border: none;
        border-radius: 3px;
        resize:none;
        padding: 10px;
        color: #000;
        font-size: 12px;
        grid-column: 1/5;
        grid-row: 3/5;
    }
    .popup .body textarea::placeholder {
        color: #555555;
    }
    .popup .body #journalSave {
        grid-column: 4/5;
        grid-row: 5/6;
        background-color: #3E6DB9;
        text-transform: capitalize;
        margin: 0 0 0 10%; /*ширина кнопки*/
    }
        .popup .body #deleteReason {
        grid-column: 3/4;
        grid-row: 5/6;
        background-color: #3E6DB9;
        text-transform: unset;
        margin: 0 -10% 0 -5%; /*ширина кнопки*/
    }
</style>
<style>
    .popup .q-if-control { /*значёк календаря*/
        background: none !important;
    }
    .popup .body .absenceDatePopup .q-if-inner {
        padding: 0 0 0 10px;
    }
    .popup .body button .q-btn-inner {
        font-size: 11px;
        margin: 0;
        padding: 0 0;
    }
    .popup .body button:active {
        box-shadow: none;
    }
</style>