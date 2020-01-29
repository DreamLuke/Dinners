<template>
    <div class="select">
        <div class="feild" @click="showSelect()" :class="validation">


            <!--есть дефолтное значение-->
            <template v-if="!!defaultType">
                <!--перебираю типы блюд-->
                <template v-for="key in dishesTypes">

                    <!--значения от пользователя есть-->
                    <template v-if="!!type_id">
                        <!--редактирование-->
                        <span v-if="key.value === type_id">
                            {{key.label[0].toUpperCase() + key.label.substr(1)}}
                        </span>
                    </template>

                    <!--значения от пользователя нет-->
                    <template v-else>
                        <span v-if="key.value === defaultType">
                            {{key.label[0].toUpperCase() + key.label.substr(1)}}
                        </span>
                    </template>

                </template>
            </template>


            <!--нет дефолтного значения-->
            <template v-else>

                <!--есть ввод от пользователя-->
                <template v-if="!!type_id">
                    <!--перебираю массив-->
                    <template v-for="key in dishesTypes">
                        <span v-if="key.value === type_id">
                            {{key.label[0].toUpperCase() + key.label.substr(1)}}
                        </span>
                    </template>
                </template>

                <!--нет ввода от пользователя-->
                <template v-else>
                    <span style="color: #555555">Выберите тип блюда</span>
                </template>

            </template>



            <img src="../../statics/icons/arrow.svg">
        </div>
        <ul>
            <li v-for="key in dishesTypes">

                <!--редактирование-->
                <template v-if="editable.edit && editable.id === key.value">

                    <!--что появится вместо карандаша-->
                    <input class="edit input"
                           type="text"
                           v-model.trim="key.label"
                    >
                    <!--Удаление-->
                    <img class="edit"
                         src="../../statics/icons/trash.svg"
                         @click="removeType(key)"
                    >
                    <!--Редактирование-->
                    <img class="edit"
                         src="../../statics/icons/accept.svg"
                         @click="editType(key)"
                    >

                </template>
                <template v-else>
                    <span @click="select(key)">{{key.label}}</span>
                    <img src="../../statics/icons/pencil.svg"
                         @click="showEdit(key)">
                </template>



            </li>
            <li>

                <!--добавления нет-->
                <template v-if="!added.add">
                    <span>Добавить тип блюда</span>
                    <img src="../../statics/icons/plus.svg" @click="showAdd()">
                </template>

                <!--добавление есть-->
                <template v-else>
                    <input class="edit input"
                           type="text"
                           v-model.trim="added.label"
                           autofocus placeholder="Введите имя"
                    >
                    <img class="edit" src="../../statics/icons/cancel.svg" @click="showAdd()">
                    <img class="edit" src="../../statics/icons/accept.svg" @click="acceptAdd()">
                </template>



            </li>
        </ul>
    </div>
</template>

<script>
    import axios from 'axios'
    import store from '../../store/admin'

    export default {
        store,
        name: 'select-custom',
        props: ['dishesTypes', 'defaultType', 'validation'],
        data() {
            return {
                type_id: '',
                editable: {edit: false, id: '', label: ''},
                added: {add: false, label: '', pattern: /^([а-яА-Я]{3,15})$/}
            }
        },
        mounted() {

            let context = this;
            //по нажатию esc - закроется список
            window.onkeydown = function( event ) {
                if ( Number(event.keyCode) === 27 ) {
                    document.querySelector('.select ul').style = 'max-height: 0px';

                    context.editable.edit = false;
                    context.added.add = false;
                }
            };

        },
        methods: {
            showEdit(data) {

                this.editable.edit = true;
                this.editable.id = data.value;
                this.editable.label = data.label;
                console.log(data);
            },
            showSelect() {
                let list = document.querySelector('.select ul');
                list.style = 'max-height: 250px';
            },
            select(data) {

                this.type_id = data.value;

                let list = document.querySelector('.select ul');
                list.style = 'max-height: 0px';

                //передать родителю значение
                this.$emit('getType', data.value);

                //убрать редактирование
                this.editable.id = '';
                this.editable.edit = false;
            },
            removeType(data) {

                axios.delete('/menu/type/destroy', {params: {id: data.value}})
                    .then(response => {

                        console.log(response.data);
                        // store.dispatch('axiosDishesTypes');

                    })
                    .catch(error => {
                        console.error(error);
                    });
            },
            editType(data) {

                //изменений нет
                if (this.editable.label === data.label) {

                    for (let key in this.editable) {
                        this.editable[key] = '';
                    }
                } else {

                    //изменения есть
                    axios.patch('/menu/type/update', {id: data.value, name: data.label})
                        .then(response => {

                            for (let key in this.editable) {
                                this.editable[key] = '';
                            }

                            store.dispatch('axiosDishesTypes');
                        })
                        .catch(error => {
                            console.error(error);
                        });
                }
            },
            showAdd() {

                this.added.add = !this.added.add;
                this.added.label = '';
            },
            acceptAdd() {

                if (this.added.pattern.test(this.added.label)) {

                    axios.post('/menu/type/create', {name: this.added.label.toLowerCase()})
                        .then(response => {

                            store.dispatch('axiosDishesTypes');
                            this.added.add = false;
                            this.added.label = '';
                        })
                        .catch(error => {
                            console.error(error);
                        });
                }
            }
        }
    }
</script>

<style scoped>
    .edit {
        opacity: 1 !important;
    }
    .input {
        border: 1px solid #bfbfbf;
        margin: 5px;
        border-radius: 5px;
        padding: 10px;
        width: auto;
        max-width: 65%;
        font-size: 13px;
    }
    .wrongInput {
        box-shadow: inset 0 0 3px red;
    }
    .select {
        position: relative;
    }
    .select .feild {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 10px;
        box-sizing: border-box;
        border-radius: 5px;
        background-color: #eeeeee;
        cursor: pointer;
        font-size: 12px;
    }
    .select .feild span {
        user-select: none;
    }
    .select ul {
        width: 100%;
        max-width: 98.75%;
        position: absolute;
        top: 5px;
        left: 2px;
        background-color: #fff;
        z-index: 1000;
        max-height:0;
        transition: 0.225s;
        border: 1px solid #eeeeee;
        overflow-y: scroll;
    }
    .select ul li {
        min-height: 40px;
        border-top: 1px solid #ccc;
        transition: 0.10s;
        display: flex;
        justify-content: space-between;
        align-self: center;
        box-sizing: border-box;
        height: 40px;
    }
    .select ul li:first-child {
        border-top: none;
    }
    .select ul li span {
        text-transform: capitalize;
        font-size: 13px;
        color: #000;
        user-select: none;
        display: block;
        height: 100%;
        width: 100%;
        padding: 10px 15px;
    }
    .select ul li img {
        cursor: pointer;
        display: block;
        opacity: 0;
        padding: 11px 10px;
        height: 40px;
        width: 40px;
        box-sizing: border-box;
    }
    .select ul li:last-child span {
        text-transform: none;
    }
    .select ul li:last-child img {
        opacity: 1;
    }
    .select ul li:hover {
        background-color: #ddd;
    }
    .select ul li:hover img {
        opacity: 1;
    }
</style>