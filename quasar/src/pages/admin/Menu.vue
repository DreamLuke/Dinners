<template>
    <q-layout>
        <q-page padding>

            <h5 class="title">Меню</h5>

            <q-table id="adminMenu"
                     :data="search"
                     :columns="columns"
                     row-key="name"
                     class="shadow-0"
                     :rows-per-page-options="[0]"
                     :pagination.sync="pagination"
                     hide-bottom
                     :separator="separator"
            >
                <!--поиск-->
                <q-tr slot="top-row" slot-scope="props">
                    <q-td>
                        <q-search no-icon
                                  hide-underline
                                  color="secondary"
                                  type="text"
                                  placeholder="Поиск..."
                                  style="font-size: 13px"
                                  v-model="filter.type"
                        />
                    </q-td>
                    <q-td>
                        <q-search no-icon
                                  hide-underline
                                  color="secondary"
                                  type="text"
                                  placeholder="Поиск..."
                                  style="font-size: 13px"
                                  v-model="filter.name"
                        />
                    </q-td>
                    <q-td>
                        <q-search no-icon
                                  hide-underline
                                  color="secondary"
                                  type="text"
                                  placeholder="Поиск..."
                                  style="font-size: 13px"
                                  v-model="filter.info"
                        />
                    </q-td>
                    <q-td></q-td>
                    <q-td></q-td>
                    <q-td></q-td>
                    <q-td></q-td>
                    <q-td></q-td>
                    <q-td></q-td>
                    <q-td></q-td>
                    <q-td></q-td>
                    <q-td></q-td>
                    <q-td></q-td>
                </q-tr>

                <q-tr slot="body"
                      slot-scope="props"
                      :props="props"
                >
                    <q-td key="type" :props="props" v-if="dishes.length">
                        <span>{{dishType(props.row.type_id, props.row.id)}}</span>
                    </q-td>

                    <q-td key="name" :props="props">
                        <span>{{props.key}}</span>
                    </q-td>

                    <q-td key="info" :props="props">
                        <span>{{props.row.composition}}</span>
                    </q-td>

                    <q-td key="calories" :props="props">
                        <span>{{props.row.calories}}</span>
                    </q-td>

                    <q-td key="count" :props="props">
                        <span>{{props.row.weight}}</span>
                    </q-td>

                    <q-td key="price" :props="props">
                        <span>{{props.row.price}}</span>
                    </q-td>


                    <template v-if="daysForDishes.length && dishes">
                        <q-td key="mon" :props="props">
                            <input type="checkbox"
                                   v-on:click="chooseDay(props.row.id, 1)"
                                   v-bind:checked="isChecked(props.row.id, 1)"
                            >
                        </q-td>
                        <q-td key="tue" :props="props">
                            <input type="checkbox"
                                   v-on:click="chooseDay(props.row.id, 2)"
                                   v-bind:checked="isChecked(props.row.id, 2)">
                        </q-td>
                        <q-td key="wed" :props="props">
                            <input type="checkbox"
                                   v-on:click="chooseDay(props.row.id, 3)"
                                   v-bind:checked="isChecked(props.row.id, 3)">
                        </q-td>
                        <q-td key="thu" :props="props">
                            <input type="checkbox"
                                   v-on:click="chooseDay(props.row.id, 4)"
                                   v-bind:checked="isChecked(props.row.id, 4)">
                        </q-td>
                        <q-td key="fri" :props="props">
                            <input type="checkbox"
                                   v-on:click="chooseDay(props.row.id, 5)"
                                   v-bind:checked="isChecked(props.row.id, 5)">
                        </q-td>
                    </template>


                    <q-td key="edit" :props="props">
                        <img src="../../statics/icons/edit.svg" v-on:click="editPopup(props.row)">
                    </q-td>
                    <q-td key="delete">
                        <img src="../../statics/icons/remove.svg" v-on:click="showConfirm(props.row.id)">
                    </q-td>
                </q-tr>
            </q-table>


            <div id="control">
                <q-btn class="shadow-0 adminMenuBtn"
                       label="Просмотреть меню"
                       size="md"
                       text-color="white"
                       rounded
                       flat
                       @click="showMenu"
                />
                <q-btn class="shadow-0 adminMenuBtn"
                       label="Добавить Блюдо"
                       size="md"
                       text-color="white"
                       rounded
                       flat
                       @click="addPopup()"
                />
            </div>

            <edit-popup :dishesTypes="sendDishesTypes" ref="open"/>
            <delete-confirm ref="showNotify" @confirmDelete="deleteDish"></delete-confirm>
        </q-page>
    </q-layout>
</template>


<style scoped>
    .q-table-container {
        overflow: unset;
        width: auto;
        height: auto;
        min-height: 40vh;
        max-height: 69vh;
        overflow-y: scroll;
    }
    .q-layout-page {
        padding-top: 2rem;
    }
</style>
<style>
    #adminMenu {
        border: 1px solid #d6d6d8;
    }
    #adminMenu .q-table-middle.scroll {
        overflow: visible;
    }

    #adminMenu .q-table {
        border-right: 1px solid #d6d6d8;
        width: 100%;
    }
    #adminMenu .q-table-middle thead tr th {
        position: sticky;
        position: -webkit-sticky;
        background: #f4f4f6;
        top: -1px;
        z-index: 1;
        background-color: #ddd;
    }

    #adminMenu .q-table-middle tbody {

    }
    #adminMenu .q-table-middle tbody td:last-child {
        border-right: 1px solid #d6d6d8;
    }

    #adminMenu .q-table-middle {
        width: 100%;
        overflow: unset;
    }

    #adminMenu .q-table tbody tr td span {
        color: #000;
    }
    #adminMenu thead tr {
        height: 23px;
    }
    #adminMenu thead th,
    #adminMenu tbody td {
        border: 1px solid #d6d6d8;
        height: 40px;
    }
    #adminMenu td img {
        cursor: pointer;
        width: 18px;
    }
    #control { /*контейнер для кнопок*/
        padding-top: 30px;
        display: flex;
        justify-content: flex-end;
        width: 100%;
    }
    #control .adminMenuBtn {
        background-color: #3E6DB9;
        float: right;
        margin: 0 0 0 15px;
        padding: 3px 25px 5px 25px;
        text-transform: capitalize;
    }
    #control .adminMenuBtn .q-btn-inner {
        text-transform: capitalize;
        font-style: normal;
        font-weight: 500;
        font-size: 12px;
        line-height: 13px;
        text-align: center;
    }
    .title {
        padding: 0;
        margin: 0 0 20px 0;
        text-align: center;
        font-style: normal;
        font-weight: bold;
        font-size: 16px;
        line-height: 29px;
        color: #0C4CBC;
    }

    /*тип*/
    #adminMenu thead tr th,
    #adminMenu tbody tr td {
        padding: 0 10px;
    }
    #adminMenu tbody tr td:nth-child(1) {
        text-transform: capitalize;
    }

    /*дни недели, редактирование, удаление*/
    #adminMenu tbody tr td:nth-last-child(1),
    #adminMenu tbody tr td:nth-last-child(2),
    #adminMenu tbody tr td:nth-last-child(3),
    #adminMenu tbody tr td:nth-last-child(4),
    #adminMenu tbody tr td:nth-last-child(5),
    #adminMenu tbody tr td:nth-last-child(6),
    #adminMenu tbody tr td:nth-last-child(7) {
        text-align: center;
        width: 45px;
        box-sizing: border-box;
        padding-top: 3px;
    }
    #adminMenu thead tr th:nth-last-child(1),
    #adminMenu tbody tr td:nth-last-child(1) {
        border-right: none;
    }
</style>


<script>
    import Vue from 'vue'
    import store from '../../store/admin'
    import { mapGetters } from 'vuex'
    import EditPopup from '../../components/admin/edit-popup.vue'
    import DeleteConfirm from '../../components/admin/delete-confirm'

    export default {
        components: {EditPopup, DeleteConfirm},
        store,
        data() {
            return {
                filter: {type: '', name: '', info: ''},
                separator: 'cell',
                pagination: {
                    page: 1,
                    rowsPerPage: 0
                },
                columns: [
                    {
                        name: 'type',
                        label: 'Тип',
                        field: 'type',
                        sortable: true,
                        align: 'center'
                    },
                    {
                        name: 'name',
                        label: 'Наименование',
                        field: 'name',
                        sortable: true,
                        style: 'text-align: center',
                        align: 'left'
                    },
                    {
                        name: 'info',
                        label: 'Состав',
                        field: 'info',
                        sortable: false,
                        style: 'text-align: center',
                        align: 'left'
                    },
                    {
                        name: 'calories',
                        label: 'Калории',
                        field: 'calories',
                        sortable: false,
                        align: 'center'
                    },
                    {
                        name: 'count',
                        label: 'Количество', //вес, штуки
                        field: 'count',
                        sortable: false,
                        align: 'center'
                    },
                    {
                        name: 'price',
                        label: 'Цена',
                        field: 'price',
                        sortable: false,
                        align: 'center'
                    },

                    {
                        name: 'mon',
                        label: 'ПН',
                        field: 'mon',
                        sortable: false,
                        align: 'center'
                    },
                    {
                        name: 'tue',
                        label: 'ВТ',
                        field: 'tue',
                        sortable: false,
                        align: 'center'
                    },
                    {
                        name: 'wed',
                        label: 'СР',
                        field: 'wed',
                        sortable: false,
                        align: 'center'
                    },
                    {
                        name: 'thu',
                        label: 'ЧТ',
                        field: 'thu',
                        sortable: false,
                        align: 'center'
                    },
                    {
                        name: 'fri',
                        label: 'ПТ',
                        field: 'fri',
                        sortable: false,
                        align: 'center'
                    },
                    {
                        name: 'edit',
                        label: '',
                        field: 'edit',
                        sortable: false,
                        align: 'center'
                    },
                    {
                        name: 'delete',
                        label: '',
                        field: 'edit',
                        sortable: false,
                        align: 'center'
                    }
                ],
            }
        },
        mounted() {
            store.dispatch('axiosDishes');
            store.dispatch('axiosDishesTypes');
            store.dispatch('axiosDaysForDishes');
        },
        methods: {
            showMenu() {
                this.$router.replace('/menu/onweek');
            },
            dishType: function (type_id, dish_id) {

                /* получаю ид блюда и тип
                 * перебираю все блюда, и нахожу блюдо при пришедшему id
                 * перебираю типы блюд и добавляю к блюдам ключ type с именем типа
                 * и возвращаю его
                 *
                 * это нужно, чтобы поиск мог искать по одной таблице dishes
                 */

                for (let key in this.dishes) {

                    if (Number(this.dishes[key].id) === Number(dish_id)) {

                        for (let jey in this.dishesTypes) {

                            if (Number(this.dishes[key].type_id) === Number(this.dishesTypes[jey].id)) {

                                this.$set(this.dishes[key], 'type', this.dishesTypes[jey].name);
                                return this.dishesTypes[jey].name;
                            }
                        }
                    }
                }
            },
            isChecked: function (id, day_num) {

                //проставляю чекбоксы на каждый день
                return this.daysForDishes[Number(day_num)].dishes.includes(Number(id));
            },
            editPopup(props) {

                //открывает окно редактирования блюда
                this.$refs.open.open({name: 'Редактирование блюда', value: 1}, props);
            },
            addPopup() {

                //открывает окно создания блюда
                this.$refs.open.open({name: 'Добавить блюдо', value: 0});
            },
            showConfirm(data) {

                this.$refs.showNotify.showNotify('Подтвердить удаление?', data);
            },
            deleteDish(data) {

                this.$axios.delete('/menu/destroy', {params: {id: data}})
                    .then(response => {

                        store.dispatch('axiosDishes');
                        store.dispatch('axiosDishesTypes');
                        store.dispatch('axiosDaysForDishes');
                }).catch(error => {
                    console.error(error);
                });
            },
            chooseDay(dish_id, day_num) {

                //добавляет или удаляет это блюдо в меню текущего дня
                this.$axios.put('/menu/update',
                    {
                        dish_id: Number(dish_id),
                        day_num: Number(day_num)
                    }
                    ).then(response => {

                    store.dispatch('axiosDaysForDishes');

                }).catch(error => {
                    console.error(error);
                });

            }
        },
        computed: {
            ...mapGetters({
                dishes: 'getDishes',
                dishesTypes: 'getDishesTypes',
                daysForDishes: 'getDaysForDishes',
            }),
            sendDishesTypes() {

                //передаю в popup типы блюд
                let arr = [];
                for (let key in this.dishesTypes) {

                    arr.push(
                        {
                            label: this.dishesTypes[key].name,
                            value: Number(this.dishesTypes[key].id)
                        }
                    );
                }

                return arr;
            },
            search() {

                //смотрим, есть ли ввод поиска
                let type = this.filter.type ? this.filter.type.toLowerCase() : '';
                let name = this.filter.name ? this.filter.name.toLowerCase() : '';
                let info = this.filter.info ? this.filter.info.toLowerCase() : '';
                let tempArr = this.dishes;


                if (type || name || info) {


                    if (type) {
                        tempArr = tempArr.filter(row => {

                            return row.type ? row.type.toLowerCase().match(type) : '';
                        });
                    }
                    if (name) {
                        tempArr = tempArr.filter(row => {

                            return row.name ? row.name.toLowerCase().match(name) : '';
                        });
                    }
                    if (info) {
                        tempArr = tempArr.filter(row => {

                            return row.composition ?
                                row.composition.toLowerCase().match(info) : '';
                        });
                    }

                    //готовый массив нужно вернуть в конце
                    return tempArr;

                } else {

                    return tempArr.sort(function(a, b) {
                        if (a.type_id > b.type_id) return 1;
                        if (a.type_id < b.type_id) return -1;
                    });
                }

            }
        }
    }
</script>
