<template>
    <div id="popupContainer">
        <div class="overlay">
            <div class="position">
                <div class="popup">
                    <div class="head">
                        <h4>{{ call.name }}</h4>
                        <img v-on:click="close()" src="../../statics/icons/close.svg">
                    </div>
                    <div class="body">

                        <div class="content">

                            <!--отправить дефолтное значение типа-->
                            <!--слот добавляется в конец списка ul в тег li-->
                            <custom-select-types
                                    @getType="setType"
                                    :dishesTypes="dishesTypes"
                                    :validation="this.fields.type.error"
                                    :defaultType="fields.type.value"
                            />
                            <q-input v-model="fields.name.value"
                                     color="grey-3"
                                     inverted-light
                                     placeholder="Введите наименование блюда"
                                     class="shadow-0"
                                     v-bind:class="fields.name.error"
                                     v-on:input="unlockBtn()"
                            />
                            <q-input v-model="fields.count.value"
                                     color="grey-3"
                                     inverted-light
                                     placeholder="Укажите количество (в г или шт)"
                                     class="shadow-0"
                                     v-bind:class="fields.count.error"
                                     v-on:input="unlockBtn()"
                            />
                            <input v-model.lazy="fields.price.value"
                                   id="priceMask"
                                   maxlength="6"
                                   placeholder="Укажите цену блюда (в грн)"
                                   v-bind:class="fields.price.error"
                                   v-on:input="unlockBtn()"
                            />
                            <q-input v-model="fields.calories.value"
                                     color="grey-3"
                                     inverted-light
                                     placeholder="Укажите количество Ккал"
                                     class="shadow-0"
                                     v-bind:class="fields.calories.error"
                                     v-on:input="unlockBtn()"
                            />
                            <textarea v-on:input="unlockBtn()"
                                      v-bind:class="fields.composition.error"
                                      v-model="fields.composition.value"
                                      placeholder="Введите описание блюда"
                            />
                        </div>
                        <q-btn id="popupSave"
                               class="shadow-0"
                               label="Сохранить"
                               size="md"
                               text-color="white"
                               rounded
                               flat
                               v-on:click="save()"
                        />
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>


<style>
    .wrongInput {
        box-shadow: inset 0 0 3px red !important;
    }
    #popupContainer {
        display: none;
    }
    #popupContainer .overlay {
        background-color: transparent;
        width: 100%;
        height: 100%;
        position: fixed;
        left: 0;
        top: 0;
        z-index: 1;
    }
    #popupContainer .position {
        margin: 27vh auto 0 auto;
        border: 1px solid #043DA0;
        min-width: 400px;
        max-width: 675px;
        width: auto;
        height: 326px;
        background-color: #fff;
        box-shadow: 0 4px 4px rgba(0, 0, 0, 0.25), 0 4px 4px rgba(0, 0, 0, 0.25);
        z-index: 1000;
    }
    #popupContainer .popup {
        position: relative;
        max-width: 675px;
        min-width: 200px;
        width: auto;
        min-height: 326px;
    }
    #popupContainer .popup .head {
        position: absolute;
        top: 0;
        left: 0;
        height: 38px;
        width: 100%;
        background-color: #136598;
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 0 10px 0 18px;
    }
    #popupContainer .popup .head h4 {
        color: #fff;
        font-style: normal;
        font-weight: bold;
        font-size: 18px;
        line-height: 29px;
        display: inline;
    }
    #popupContainer .popup .head img {
        display: block;
        height: 32px;
        width: 32px;
        cursor: pointer;
    }
    #popupContainer .popup .body {
        position: absolute;
        top: 38px;
        width: 100%;
        max-height: 287px;
        height: auto;
        padding: 3.75% 5% 3% 5%;
        box-sizing: border-box;
        overflow-y: hidden;
    }
    #popupContainer .popup .body .content {
        display: grid;
        grid-template-columns: repeat(6, 1fr);
        grid-row-gap: 11px;
        grid-column-gap: 10px;
        margin-bottom: 20px;

        font-style: normal;
        font-weight: 500;
        font-size: 14px;
        line-height: 17px;
        letter-spacing: 0.5px;
    }
    #popupContainer .popup .body .content .q-input,
    #popupContainer .popup .body .content textarea {
        font-size: 12px;
    }
    #popupContainer .popup .body .content .select {
        grid-column: 1/4;
    }
    #popupContainer .popup .body .content .q-input:nth-child(2) {
        grid-column: 4/7;
    }
    #popupContainer .popup .body .content .q-input:nth-child(3) {
        grid-column: 1/3;
    }
    #priceMask {
        grid-column: 3/5;
        border-radius: 5px;
        border: none;
        font-size: 12px;
        background-color: #eee;
        padding: 8px;
    }
    #priceMask::placeholder {
        color: #555555;
    }
    #popupContainer .popup .body .content .q-input:nth-child(5) {
        grid-column: 5/7;
    }
    #popupContainer .popup .body .content textarea {
        grid-column: 1/7;
        height: 85px;
        background-color: #eeeeee;
        border: none;
        border-radius: 3px;
        resize:none;
        padding: 10px;
        color: #000;
    }
    #popupContainer .popup .body .content textarea::placeholder {
        color: #555555;
    }
    #popupContainer input[type=text]::placeholder {
        color: #555555 !important;
    }
    .select .q-input-target {
        color: #555555 !important;
    }
    #popupContainer .popup .body #popupSave {
        background-color: #3E6DB9;
        padding: 10px 40px;
        float: right;
        text-transform: capitalize;
    }
    #popupContainer .popup .body #popupSave .q-btn-inner {
        font-size: 11px;
        margin: 0;
        padding: 0;
    }
    #popupContainer .popup .body #popupSave:active {
        box-shadow: none;
    }

    @media (max-width: 630px) {

        #popupContainer .popup .body {
            padding: 4.5% 5% 3% 5%;
        }
    }
    @media (max-width: 500px) {

        #popupContainer .popup .body {
            padding: 6% 5% 3% 5%;
        }
    }
    @media (max-width: 450px) {

        #popupContainer .popup .body .content .select {
            grid-column: 1/7;
        }
        #popupContainer .popup .body .content .q-input:nth-child(2) {
            grid-column: 1/7;
        }
        #popupContainer .popup .body .content .q-input:nth-child(3) {
            grid-column: 1/7;
        }
        #priceMask {
            grid-column: 1/7;
        }
        #popupContainer .popup .body .content .q-input:nth-child(5) {
            grid-column: 1/7;
        }
        #popupContainer .popup .body .content textarea {
            grid-column: 1/7;
        }

        #popupContainer .popup .body {
            padding: 3%;
        }

    }
</style>

<script>
    import CustomSelectTypes from './custom-select-types'

    export default {
        name: 'edit-popup',
        props: ['dishesTypes'],
        components: {CustomSelectTypes},
        data() {
            return {
                id: '',
                fields: {
                    type: {
                        value: '',
                        error: '',
                        pattern: /^([0-9]{1,3})$/
                    },
                    name: {
                        value: '',
                        error: '',
                        pattern: /^([а-яА-ЯёЁa-zA-Z '-]{3,50})$/
                    },
                    count: {
                        value: '',
                        error: '',
                        pattern: /^([0-9]{1,3})([ ]{0,1})([а-яА-Я]{0,5})$/
                    },
                    calories: {
                        value: '',
                        error: '',
                        pattern: /^([0-9]{1,5})$/
                    },
                    price: {
                        value: '',
                        error: '',
                        pattern: /^([0-9]{1,2})$|^([0-9]{1,3})([.]{1})([0-9]{2})$/
                    },
                    composition: {
                        value: '',
                        error: '',
                        pattern: /^([a-zA-Zа-яА-ЯёЁ., ]{5,150})$/
                    }
                },
                call: '',
            }
        },
        methods: {
            clearValues() {

                //нужно убирать данные, чтобы они не появлялись по новому открытию
                this.id = '';
                for (let key in this.fields) {
                    this.fields[key].value = '';
                    this.fields[key].error = '';
                }
            },
            unlockBtn() {
                document.querySelector('#popupSave').removeAttribute('disabled');
                document.querySelector('#popupSave').style = 'background-color: #3E6DB9';
            },
            open(call, data) {

                $('#priceMask').mask('##.##00.00', {reverse: true});

                //блокирую кнопку - сохранить можно только изменив содержимое
                document.querySelector('#popupSave').setAttribute('disabled', 'disabled');

                this.clearValues();
                this.$el.style.display = 'block';

                //если это окно редактирования
                if (call.value) {
                    this.call = call;
                    this.id = data.id; //ид блюда
                    this.fields.name.value = data.name;
                    this.fields.count.value = data.weight;
                    this.fields.calories.value = data.calories;
                    this.fields.price.value = Number(data.price);
                    this.fields.type.value = Number(data.type_id);
                    this.fields.composition.value = data.composition;
                } else {

                    //это окно добавления
                    this.call = call;
                }
            },
            close () {
                this.$el.style.display = 'none';
                this.unlockBtn();
                this.clearValues();
                this.call = '';

                //закрывает селект по закрытию модалки
                document.querySelector('.select ul').style.display = 'none';

                //убираю у селекта выбранный тип блюда
                this.$children[0].type_id = '';
                this.$children[0].added.add = false;
                this.$children[0].editable.edit = false;
            },
            save() {
                let errCount = 0;
                for (let key in this.fields) {
                    if (!this.fields[key].pattern.test(this.fields[key].value) ||
                         this.fields[key].value === null) {
                        this.$set(this.fields[key], 'error', 'wrongInput');
                        errCount++;
                    } else {
                        this.$set(this.fields[key], 'error', '');
                    }
                }

                //ошибок нет
                if (!errCount) {

                    //нужно сформировать отправляемые данные
                    let sendData = {
                        id:          Number(this.id),
                        type:        this.fields.type.value,
                        name:        this.fields.name.value,
                        count:       this.fields.count.value,
                        price:       Number(this.fields.price.value),
                        calories:    Number(this.fields.calories.value),
                        composition: this.fields.composition.value,
                    };
                    this.send(sendData);
                }
            },
            send(sendData) {

                //закрывает по сохранению
                document.querySelector('.select ul').style.display = 'none';

                this.$axios.put('/menu/create', sendData).then(response => {

                    this.$store.dispatch('axiosDishes');
                    this.$store.dispatch('axiosDishesTypes');
                    this.$store.dispatch('axiosDaysForDishes');

                    this.close()
                }).catch(error => {
                    console.log(error);

                    document.querySelector('#popupSave').style = 'background-color:rgba(255, 0, 0, 0.6)';
                    this.fields.name.error = 'wrongInput';
                    document.querySelector('#popupSave').setAttribute('disabled', 'disabled');

                    let dishName = this.fields.name.value;
                    this.fields.name.value = 'Уже есть такое блюдо';

                    //показываем, что админ ошибся
                    setTimeout(function () {

                        //отдаём значение поля для исправления
                        this[0].fields.name.value = this[1];
                    }.bind([this, dishName]), 1500);
                });
            },
            setType(data) {

                this.fields.type.value = data;

                //значение селекта меняется, а значит кнопка должна реагировать на изменения
                this.unlockBtn();
            }
        },
    }
</script>
