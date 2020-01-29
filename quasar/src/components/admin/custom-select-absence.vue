<template>
    <div class="select">
        <div class="feild" @click="showSelect()" :class="validation">

            <!--есть дефолтное значение-->
            <template v-if="!!defaultType">
                <!--перебираю типы блюд-->
                <template v-for="key in reasons">

                    <!--значения от пользователя есть-->
                    <template v-if="!!id">
                        <span v-if="key.id === id">
                            {{key.name}}
                        </span>
                    </template>

                    <!--значения от пользователя нет-->
                    <template v-else>
                        <span v-if="Number(key.id) === Number(defaultType)">
                            {{key.name}}
                        </span>
                    </template>

                </template>
            </template>


            <!--нет дефолтного значения-->
            <template v-else>
                <!--есть ввод от пользователя-->
                <template v-if="!!id">
                    <!--перебираю массив-->
                    <template v-for="key in reasons">
                        <span v-if="Number(key.id) === Number(id)">{{key.name}}</span>
                    </template>
                </template>

                <!--нет ввода от пользователя-->
                <template v-else>
                    <span style="color: #555555">Укажите тип причины</span>
                </template>
            </template>

            <img src="../../statics/icons/arrow.svg">
        </div>

        <!--СПИСОК-->
        <ul>
            <li v-for="key in reasons">

                <!--РЕДАКТИРОВАНИЕ-->
                <template v-if="edit && Number(id) === Number(key.id)">

                    <!--что появится вместо карандаша-->
                    <input class="edit inputLabel"
                           style="width: 90%;"
                           type="text"
                           v-model.trim="key.name"
                           placeholder="Укажите название причины"
                           :class="editable.label.error"
                    >
                    <input class="edit inputShort"
                           type="text"
                           v-model.trim="key.shortName"
                           placeholder="Сокращение"
                           maxlength="2"
                           :class="editable.short.error"
                    >
                    <!--Удаление-->
                    <img class="edit icon" src="../../statics/icons/trash.svg" @click="removeType(key)">
                    <!--Редактирование-->
                    <img class="edit icon" src="../../statics/icons/accept.svg" @click="editType(key)">
                </template>

                <!--ПРОСТО ОТОБРАЖЕНИЕ-->
                <template v-else>
                    <!--no user input-->
                    <template v-if="!id">

                        <!--default-->
                        <template v-if="Number(defaultType) === Number(key.id)">
                            <span @click="select(key.id)" class="selected">{{key.name}}</span>
                            <img src="../../statics/icons/pencil.svg" @click="showEdit(key)">
                        </template>

                        <!--no default-->
                        <template v-else>
                            <span @click="select(key.id)">{{key.name}}</span>
                            <img src="../../statics/icons/pencil.svg" @click="showEdit(key)">
                        </template>

                    </template>

                    <!--user input-->
                    <template v-else>

                        <template v-if="Number(defaultType) === Number(key.id) && Number(id) === Number(key.id)">
                            <span @click="select(key.id)" class="selected">{{key.name}}</span>
                            <img src="../../statics/icons/pencil.svg" @click="showEdit(key)">
                        </template>

                        <!--default-->
                        <template v-if="Number(defaultType) === Number(key.id) && Number(id) !== Number(key.id)">
                            <span @click="select(key.id)">{{key.name}}</span>
                            <img src="../../statics/icons/pencil.svg" @click="showEdit(key)">
                        </template>

                        <template v-else-if="Number(defaultType) !== Number(key.id) && Number(id) === Number(key.id)">
                            <span @click="select(key.id)" class="selected">{{key.name}}</span>
                            <img src="../../statics/icons/pencil.svg" @click="showEdit(key)">
                        </template>

                        <!--no default-->
                        <template v-else-if="Number(defaultType) !== Number(key.id) && Number(id) !== Number(key.id)">
                            <span @click="select(key.id)">{{key.name}}</span>
                            <img class="icon" src="../../statics/icons/pencil.svg" @click="showEdit(key)">
                        </template>

                    </template>
                </template>
            </li>

            <!--ДОБАВЛЕНИЕ-->
            <li>
                <!--добавления нет-->
                <template v-if="!add">
                    <span>Добавить тип причины</span>
                    <img src="../../statics/icons/plus.svg" @click="showAdd()">
                </template>

                <!--добавление есть-->
                <template v-else>
                    <input class="edit inputLabel"
                           type="text"
                           v-model="added.label.value"
                           placeholder="Название причины"
                           maxlength="50"
                           :class="added.label.error"
                           autofocus
                    >
                    <input class="edit inputShort"
                           type="text"
                           v-model="added.short.value"
                           placeholder="Сокращение"
                           maxlength="2"
                           :class="added.short.error"
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
        name: 'custom-select-absence',
        props: ['defaultType', 'validation', 'reasons'],
        data() {
            return {
                id: '',
                edit: false,
                editable: {
                    label: {value: '', error: ''},
                    short: {value: '', error: ''},
                },

                add: false,
                added: {
                    label: {value: '', pattern: /^([а-яА-Я ]{3,50})$/, error: ''},
                    short: {value: '', pattern: /^([а-яА-Я]{1,2})$/  , error: ''},
                }
            }
        },
        mounted() {

            let context = this;
            //по нажатию esc - закроется список
            window.onkeydown = function( event ) {
                if ( event.keyCode === 27 ) {
                    document.querySelector('.select ul').style = 'max-height: 0px';

                    //убрать добавление и редактирование
                    context.edit = false;
                    context.add = false;

                    //сбросить ошибки
                    for (let key in context.editable) {
                        context.editable[key].value = '';
                        context.editable[key].error = '';
                    }
                }
            };
        },
        methods: {
            showEdit(data) {
                this.edit = true;
                this.id = Number(data.id);
                this.editable.label.value = data.name;
                this.editable.short.value = data.shortName;
            },
            showSelect() {
                let list = document.querySelector('.select ul');
                list.style = 'max-height: 250px';
            },
            select(data) {
                this.id = Number(data);
                let list = document.querySelector('.select ul');
                list.style = 'max-height: 0px';

                //закрывать редактирование
                this.edit = false;
                //закрывать добавление
                this.add = false;

                //чистить ошибки
                for (let key in this.editable) {

                    this.editable[key].value = '';
                    this.editable[key].error = '';
                }

                for (let key in this.added) {
                    this.added[key].value = '';
                    this.added[key].error = '';
                }

                //передать родителю значение
                this.$emit('getType', this.id);

            },
            removeType(data) {

                axios.delete('/journal/type/destroy', {params: {id: Number(data.id)}})
                    .then(response => {

                        store.dispatch('axiosReasons');
                        store.dispatch('axiosAbsences');

                        //закрыть редактирование
                        this.edit = false;
                        //сбросить данные
                        for (let key in this.editable) {
                            this.editable[key].value = '';
                            this.editable[key].error = '';
                        }
                    })
                    .catch(error => {
                        console.error(error);
                    })
            },
            editType(data) {

                //изменения есть?
                if (this.editable.label.value === data.name &&
                    this.editable.short.value === data.shortName) {

                    //без изменений
                    for (let key in this.editable) {
                        this.editable[key].value = '';
                    }

                    //закрыть редактирование
                    this.edit = false;

                    //сбросить данные
                    for (let key in this.editable) {
                        this.editable[key].value = '';
                        this.editable[key].error = '';
                    }

                } else { //есть изменения

                    //цикл не сделал, потому-что data.name и data.shortName
                    let error = 0;
                    if (!this.added.label.pattern.test(data.name)) {
                        this.editable.label.error = 'wrongInput';
                        error++;
                    } else {
                        this.editable.label.error = '';
                    }

                    if (!this.added.short.pattern.test(data.shortName)) {
                        this.editable.short.error = 'wrongInput';
                        error++;
                    } else {
                        this.editable.short.error = '';
                    }

                    //нет ошибок
                    if (!error) {

                        //запрос
                        axios.patch('journal/type/update', {id: Number(this.id), name: data.name, short: data.shortName})
                            .then(response => {

                                //сбросить данные
                                for (let key in this.editable) {
                                    this.editable[key].value = '';
                                    this.editable[key].error = '';
                                }

                                //закрыть редактирование
                                this.edit = false;
                            })
                            .catch(error => {
                                console.error(error);
                            })
                    } else {

                        //есть ошибки
                        console.log('errors');
                    }
                }



            },
            showAdd() {
                this.add = !this.add;

                //сбросить значения и ошибки
                for (let key in this.added) {
                    this.added[key].value = '';
                    this.added[key].error = '';
                }
            },
            acceptAdd() {

                let errors = 0;
                for (let key in this.added) {
                    if (!this.added[key].pattern.test(this.added[key].value)) {
                        this.added[key].error = 'wrongInput';
                        errors++;
                    } else {
                        this.added[key].error = '';
                    }
                }

                //нет ошибок
                if (!errors) {

                    axios.post('journal/type/create',
                        {name: this.added.label.value, short: this.added.short.value})
                        .then(response => {

                            //подгружаю все причины
                            store.dispatch('axiosReasons');

                            //закрываю добавление
                            this.add = false;

                            //сбрасываю данные добавления
                            for (let key in this.added) {

                                this.added[key].value = '';
                                this.added[key].error = '';
                            }

                        })
                        .catch(error => {
                            console.error(error);
                        })

                } else {

                    console.log('errors');
                }
            }
        }
    }
</script>

<style scoped>
    .edit {
        opacity: 1 !important;
    }
    .inputLabel {
        border: 1px solid #bfbfbf;
        margin: 5px;
        border-radius: 5px;
        padding: 10px;
        padding-left: 9px;
        max-width: 40%;
        font-size: 13px;
        height: 30px;
    }
    .inputShort {
        border: 1px solid #bfbfbf;
        margin: 5px;
        border-radius: 5px;
        padding: 10px;
        max-width: 20%;
        font-size: 13px;
        height: 30px;
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
    .select ul {
        width: 98.6%;
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
        /*min-height: 49px;*/
        border-top: 1px solid #ccc;
        transition: 0.10s;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-sizing: border-box;
        padding: 0;
    }
    .select ul li:first-child {
        border-top: none;
    }
    .select ul li span {
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
    .selected {
        text-decoration: underline;
    }
</style>