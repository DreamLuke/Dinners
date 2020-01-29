<template>
    <div class="overlay">
        <div class="popup">
            <div class="head">
                <h4 class="title">{{title}}</h4>
                <img src="../../statics/icons/close.svg" @click="hideUser">
            </div>
            <div class="body">

                <q-input v-model="data.name.value"
                         color="grey-3"
                         inverted-light
                         placeholder="Введите фамилию, имя сотрудника"
                         class="shadow-0"
                         :class="data.name.error"
                />
                <q-input v-model="data.email.value"
                         color="grey-3"
                         inverted-light
                         placeholder="Укажите e-mail сотрудника"
                         class="shadow-0"
                         :class="data.email.error"
                />
                <q-input v-model="data.telegram.value"
                         color="grey-3"
                         inverted-light
                         placeholder="Укажите Telegram сотрудника"
                         class="shadow-0"
                         :class="data.telegram.error"
                />

                <q-btn class="shadow-0"
                       label="Сохранить"
                       size="md"
                       text-color="white"
                       rounded
                       flat
                       @click="save"
                />

            </div>
        </div>
    </div>
</template>


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
        z-index: 1;
    }
    .popup {
        position: relative;
        width: auto;
        min-width: 300px;
        max-width: 500px;
        height: 290px;
        margin: 0 auto;
        top: 35vh;
        overflow: hidden;
        border: 1px solid #043DA0;
        box-shadow: 0 4px 4px rgba(0, 0, 0, 0.25), 0 4px 4px rgba(0, 0, 0, 0.25);
    }
    .popup .head {
        position: absolute;
        height: 38px;
        width: 100%;
        background-color: #136598;
        padding: 0 10px 0 18px;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }
    .popup .head .title {
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
        height: 87%;
        padding: 15px 25px 15px 25px;
        overflow: hidden;

        display: grid;
        grid-template-columns: repeat(4, 1fr);
        grid-template-rows: repeat(3, 1fr);
        grid-row-gap: 15px;
        background-color: #fff;
    }
    .q-input {
        height: 40px;
        grid-column: 1/5;
        color: #555555 !important;
        font-size: 14px;
    }
    button {
        grid-column: 4/5;
        margin-top: 10px;
        background-color: #3E6DB9;
        padding: 10px 30px 11px 30px;
        float: right;
        text-transform: capitalize;
        font-size: 12px !important;
    }
    button .q-btn-inner {
        font-size: 11px;
        margin: 0;
        padding: 0 0;
    }
    button:active {
        box-shadow: none;
    }
</style>


<script>
    import axios from 'axios'
    import store from '../../store/admin'

    export default {
        store,
        name: 'user-popup',
        data() {
            return {
                title: '',
                id: '',
                data: {
                    name: {
                        value: '',
                        error: '',
                        pattern: /^([а-яА-ЯёЁa-zA-Z '-]{3,50})$/
                    },
                    email: {
                        value: '',
                        error: '',
                        pattern: /(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])/
                    },
                    telegram: {
                        value: '',
                        error: '',
                        pattern: /^([0-9a-zA-Z_]{3,50})$/
                    }
                }
            }
        },
        methods: {
            showUser: function (title, data) {

                if (Number(title.val) === 1) {

                    //редактирование
                    this.title = title.title;

                    this.id = data.id;
                    this.data.name.value = data.name;
                    this.data.email.value = data.email;
                    this.data.telegram.value = data.telegram;

                } else {

                    //добавление
                    this.title = title.title;
                }

                this.$el.style.display = 'block';
            },
            hideUser() {
                this.$el.style.display = 'none';
                this.title = '';
                this.id = '';

                for (let key in this.data) {

                    this.data[key].value = '';
                    this.data[key].error = '';
                }
            },
            save() {

                let errCount = 0;
                for (let key in this.data) {

                    if (!this.data[key].pattern.test(this.data[key].value) ||
                        this.data[key].value === null) {

                        this.data[key].error = 'wrongInput';
                        errCount++;
                    } else {
                        this.data[key].error = '';
                    }
                }

                if (!errCount) {

                    let arr = {
                        id:       this.id,
                        name:     this.data.name.value,
                        email:    this.data.email.value,
                        telegram: this.data.telegram.value,
                    };

                    this.send(arr);
                }
            },
            send(data) {

                axios.put('/control/create', data)
                    .then(response => {

                        this.hideUser();
                        store.dispatch('axiosUsers');
                    })
                    .catch(error => {

                        let answer = JSON.parse(error.request.response).errors;
                        let fields = Object.keys(this.data);
                        let temp = {};


                        for (let key in answer) {
                            for (let jey in fields) {

                                if (key === fields[jey]) {

                                    this.data[key].error = 'wrongInput';

                                    temp[key] = this.data[key].value;
                                    this.data[key].value = 'Этот ' + key + ' занят';


                                    // показываем, что админ ошибся
                                    setTimeout(function () {

                                        // отдаём значение поля для исправления
                                        this[0].data[this[1]].value = this[2];
                                    }.bind([this, key,temp[key]]), 1500);

                                }
                            }
                        }
                    })
            }
        }
    }
</script>

