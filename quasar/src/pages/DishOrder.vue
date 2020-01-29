<!--CUSTOM ROWS-->
<template>
    <q-layout>
        <q-page padding class="docs-table">

            <div id="headContainer">
                <days-of-week v-on:sendDay="getDay"></days-of-week>
                <q-checkbox v-model="autoOrder"
                            label="Автозаказ"
                            color="light-blue-9"
                />
            </div>

            <!--{{'pB ' + this.$store.state.personalBalance}}-->
            <!--{{'b ' + this.$store.state.balance}}-->

            <q-table id="DishOrder"
                     :data="tableDataDay"
                     :columns="columns"
                     row-key="name"
                     class="shadow-0"
                     hide-bottom
                     :rows-per-page-options="[0]"
                     :pagination.sync="pagination"
                     table-style="width: 100%;"
            >
                <q-tr slot="body"
                      slot-scope="props"
                      :props="props"
                      :class="{'hightlight': props.row.count > 0}"
                      v-if="showAllDishes[orderDay] || props.row.count > 0"
                >

                    <!--Наименование-->
                    <q-td key="name" :props="props">
                        <img :src="showImg(props.row.type_id)">

                        <div>
                            <span class="name"
                                  @click="showComposition(props.row.id)"
                                  v-if="!props.row.showComposition"
                            >{{props.key}}</span>
                            <span v-else
                                  class="composition"
                                  @click="showComposition(props.row.id)"
                            >{{props.row.composition ? props.row.composition:'Нет описания'}}</span>

                            <span class="weight">{{props.row.weight}}</span>
                        </div>
                    </q-td>

                    <!--Количество-->
                    <q-td key="count" :props="props">
                        <div class="row items-center justify-between no-wrap count"
                             :class="{'align': !showAllDishes[orderDay]}">
                            <q-btn size="sm"
                                   round dense
                                   color="light"
                                   text-color="blue-10"
                                   icon="remove"
                                   @click="removeDishFromOrder(props.row.id, tableDataDay)"
                                   class="q-mr-xs shadow-0"
                                   v-if="showAllDishes[orderDay]"
                            />
                            <div>
                                <span>{{props.row.count}}</span>
                            </div>
                            <q-btn size="sm"
                                   round dense
                                   color="light"
                                   text-color="blue-10"
                                   icon="add"
                                   @click="addDishToOrder(props.row.id, tableDataDay)"
                                   class="q-mr-sm shadow-0"
                                   v-if="showAllDishes[orderDay]"
                            />
                        </div>
                    </q-td>

                    <!--Цена-->
                    <q-td key="price" class="text-center">
                        <span>{{props.row.price}}</span>
                    </q-td>
                </q-tr>
            </q-table>

            <!--вывод кнопкок-->
            <div class="btnContainer">
                <q-btn id="makeOrder"
                       class="shadow-0"
                       label="Редактировать заказ"
                       size="md"
                       text-color="white"
                       rounded
                       @click="editOrder"
                       v-if="!showAllDishes[orderDay]"
                />

                <q-btn id="makeOrder"
                       class="shadow-0"
                       label="Оформить заказ"
                       size="md"
                       text-color="white"
                       rounded
                       @click="createOrder"
                       v-if="showAllDishes[orderDay]"
                />
            </div>

            <!--<user-balance :balance="balance"></user-balance> &lt;!&ndash; компонент баланса пользователя &ndash;&gt;-->
            <user-balance :total=this.$store.state.total[orderDay] :balance=this.$store.state.balance[orderDay] :usedPersonalBalance=this.$store.state.usedPersonalBalance[orderDay]></user-balance>
            <!-- компонент баланса пользователя -->

            <autoorder-popup ref="open"></autoorder-popup>


            <!-- МОДАЛКА ОФОРМЛЕНИЯ ЗАКАЗА-->
            <notify ref="showNotify"/>
            <!--  this.$refs.showNotify.showNotify(СОДЕРЖАНИЕ) -->

            <!--  Ваш заказ принят! -->
            <!--  Невозможно оформить заказ! Пожалуйста, выберите блюда!  -->

        </q-page>
    </q-layout>
</template>

<style>
    #DishOrder .align {
        justify-content: center;
    }
    #headContainer #daysOfWeek {
        overflow: hidden;
        max-height: 10vh;
        min-height: auto;
        margin: 0 auto 10px auto;
    }

    #DishOrder .name,
    #DishOrder .composition {
        display: block;
        cursor: pointer;
        max-width: 300px;
        max-height: 50px;
        white-space: pre-wrap;
        box-sizing: border-box;
        overflow: hidden;
    }

    #headContainer {
        width: 100%;
        display: grid;
        grid-template-columns: 6fr 1fr;
    }

    #headContainer .q-option {
        margin: 0 auto;
        font-weight: bold;
        color: #3E6DB9;
        padding-left: 5%;
        user-select: none;
    }

    #headContainer .q-layout-page {
        padding: 1rem 3rem;
    }

     #DishOrder .hightlight {
        background-color: #E7E7E7;
    }

    .btnContainer {
        width: 85%;
        display: flex;
        justify-content: flex-end;
        margin-top: 44px;
    }

    #makeOrder {
        text-transform: initial;
        background-color: #3E6DB9;
        width: 133px;
        height: 34px;
    }

    #makeOrder .q-btn-inner {
        font-size: 11px;
    }

    #DishOrder {
        width: 85%;
    }

    #DishOrder thead {
        border-color: #E7E7E7;
    }
    #DishOrder .q-table-middle {
        max-height: 61vh;
    }
    #DishOrder thead tr th {
        position: sticky;
        position: -webkit-sticky;
        top: 0;
        z-index: 1;
        background-color: #f4f4f6;
        font-size: 14px;
        line-height: 18px;
        font-weight: normal;
        color: #A6A6A6;
        padding: 10px 0 0 0;
    }

    #DishOrder thead tr th:first-child {
        padding-left: 3%;
    }

    #DishOrder tbody {

    }

    #DishOrder tbody tr {

    }

    #DishOrder tbody tr td {
        border-color: #E7E7E7;
        color: #043DA0;
        font-size: 24px;
        height: 78px;
        margin: 0 auto;
    }

    #DishOrder tbody tr td:first-child {
        font-size: 14px;
        display: flex;
        align-items: center;
        padding: 0 0 0 7%;
    }

    #DishOrder tbody tr td:nth-child(2) {
        color: #494949;
        padding: 0 0 0 0.5%;
    }

    #DishOrder tbody tr td img {
        margin-right: 32px;
        width: 46px;
        height: 44px;
    }

    #DishOrder .weight {
        font-style: normal;
        font-weight: normal;
        font-size: 11px;
        line-height: 14px;
        display: flex;
        align-items: flex-end;
        color: #A6A6A6;
        padding-top: 5px;
    }
</style>

<script>
    import DaysOfWeek from "../components/days-of-week.vue";
    import UserBalance from "../components/user-balance";
    import autoorderPopup from "../components/autoorder-popup";
    import notify from '../components/notification';

    export default {
        components: {DaysOfWeek, UserBalance, autoorderPopup, notify},
        data() {
            return {
                autoOrder: false,
                pagination: {
                    page: 1,
                    rowsPerPage: 0 // 0 means all rows
                },
                columns: [
                    {
                        name: 'name',
                        label: 'Наименование',
                        field: 'name',
                        align: 'left',
                        style: 'width: 50%'
                    },
                    {
                        name: 'count',
                        label: 'Количество',
                        field: 'count',
                        align: 'center',
                        style: 'width: 20%'
                    },
                    {
                        name: 'price',
                        label: 'Цена (грн.)',
                        field: 'price',
                        align: 'center',
                        style: 'width: 25%'
                    }
                ],
                tableData: [],
                tableDataMonday: [],
                tableDataTuesday: [],
                tableDataWednesday: [],
                tableDataThursday: [],
                tableDataFriday: [],

                numberForSpoon: [0, 0, 0, 0, 0], // количество блюд, для которых нужна ложка (с учётом дня заказа)
                numberForFork: [0, 0, 0, 0, 0], // количество блюд, для которых нужна вилка (с учётом дня заказа)
                numberForSaladTara: [0, 0, 0, 0, 0], // количество тары для салатов (с учётом дня заказа)
                garnishIds: [[], [], [], [], []], // id выбранных гарниров для расчёта тары (с учётом дня заказа)
                meatIds: [[], [], [], [], []], // id выбранных мясных блюд для расчёта тары (с учётом дня заказа)
                numberForGarnishOrMeatTara: [0, 0, 0, 0, 0], // количество тары для гарнира и/или мясного (с учётом дня заказа)
                numberForGarnishTara: [0, 0, 0, 0, 0], // количество тары в которой есть гарнир (с учётом дня заказа), необходимо для правильного расчёта стоимости тары
                numberForMeatTara: [0, 0, 0, 0, 0], // количество тары в которой есть мясо (с учётом дня заказа), необходимо для правильного расчёта стоимости тары
                dishesOrder: [[], [], [], [], []], // массив для хранения блюд, которые выбраны в заказе

                showAllDishes: [true, true, true, true, true], // для отображения страницы заказа блюд в режиме всех блюд или в режиме редактирования заказа
                dishes: [],
                requirementsOrder: [[], [], [], [], []], // массив для хранения посуды, которая необходима для заказа
                usedPersonalBalance: [0, 0, 0, 0, 0], // Использованный личный баланс

                existOrdersIds: [], // Информация о id по заказам, которые уже существуют
                existOrdersDates: [], // Информация о датах по заказам, которые уже существуют
                existOrdersDishes: [], // Информация о блюдах по заказам, которые уже существуют
                existOrdersDishesTypes: [], // Информация о типах по заказам, которые уже существуют
                existOrderSums: [], // Информация о суммах по заказам, которые уже существуют

                ordersAtSession: [false, false, false, false, false], // Были ли сделаны заказы на какие-то дни в течении сессии

            }
        },
        computed: {
            daysForDishes() { // хранит данные о том какие блюда доступны в опредлённый день недели
                return this.$store.state.daysForDishes
            },
            tableDataDay() {
                if (this.$store.state.orderDay == 0) {
                    return this.tableDataMonday;
                } else if (this.$store.state.orderDay == 1) {
                    return this.tableDataTuesday;
                } else if (this.$store.state.orderDay == 2) {
                    return this.tableDataWednesday;
                } else if (this.$store.state.orderDay == 3) {
                    return this.tableDataThursday;
                } else if (this.$store.state.orderDay == 4) {
                    return this.tableDataFriday;
                }
            },
            dishesTypes() {
                return this.$store.state.dishesTypes
            },
            dishesToRequirements() {
                return this.$store.state.dishesToRequirements
            },
            requirements() {
                return this.$store.state.requirements
            },
            orderDay() {
                if (this.$store.state.orderDay == 0) {
                    return 0;
                } else if (this.$store.state.orderDay == 1) {
                    return 1;
                } else if (this.$store.state.orderDay == 2) {
                    return 2;
                } else if (this.$store.state.orderDay == 3) {
                    return 3;
                } else if (this.$store.state.orderDay == 4) {
                    return 4;
                }
            },
            balance() {
                if (this.orderDay == 0) {
                    return this.$store.state.balance[0];
                } else if (this.orderDay == 1) {
                    return this.$store.state.balance[1];
                } else if (this.orderDay == 2) {
                    return this.$store.state.balance[2];
                } else if (this.orderDay == 3) {
                    return this.$store.state.balance[3];
                } else if (this.orderDay == 4) {
                    return this.$store.state.balance[4];
                }
            },
        },
        mounted() {
            this.$axios.get(('/get-orders-to-week')).then((response) => {
                for (let i = 0; i < response.data.existOrders.length; i++) {
                    this.$axios.get('/get-order-sum/' + response.data.existOrders[i][0]['id'] + '/')
                        .then((response2) => {
                            // console.log('sum ' + +response.data.sum.toFixed(2));
                            this.existOrdersIds[i] = response.data.existOrders[i][0]['id'];
                            this.existOrdersDates[i] = response.data.existOrders[i][0]['date'];

                            let arr = [];
                            for (let j = 0; j < response.data.existOrdersToDishes[i].length; j++) {
                                arr.push(response.data.existOrdersToDishes[i][j]);
                            }
                            this.existOrdersDishes[i] = arr;


                            let arrTypes = [];
                            for (let j = 0; j < response.data.existOrdersToDishesTypes[i].length; j++) {
                                arrTypes.push(response.data.existOrdersToDishesTypes[i][j]);
                            }
                            this.existOrdersDishesTypes[i] = arrTypes;

                            this.existOrderSums[i] = +response2.data.sum.toFixed(2);

                            this.getAllDishesFromStore();
                        }).catch((err) => {
                        console.log('Ошибка 55555 ' + err)
                    });
                }
                if (+response.data.existOrders.length == 0) {
                    this.getAllDishesFromStore();
                }
            }).catch((err) => {
                console.log('Ошибка 5 ' + err)
            });

            // this.getOrdersToWeek();

            this.$store.dispatch('getBalanceFromDB');
            this.$store.dispatch('getTodayDayOfWeek');
            this.$store.dispatch('getOrderWeekDates');
            this.$store.dispatch('getDaysForDishes');
            this.$store.dispatch('getDishesTypes');
            this.$store.dispatch('getDishesToRequirements');
            this.$store.dispatch('getRequirements');
            // this.getAllDishesFromStore();
        },
        methods: {
            showImg(type_id) {

                for (let key in this.dishesTypes) {

                    if (Number(this.dishesTypes[key].id) === Number(type_id)) {

                        if (this.dishesTypes[key].image_link) {
                            return require('../statics/food/' + this.dishesTypes[key].image_link);
                        } else {
                            return require('../statics/food/default.svg');
                        }
                    }
                }
            },
            showComposition(id) {
                //переключатель состава блюда
                this.tableDataDay[id - 1].showComposition = !this.tableDataDay[id - 1].showComposition;
            },
            sortDishesByDays: function (daysIndex, allDishes, dishesArrForCount) {
                // console.log('_____111');
                let i = 1;
                let arr = [];

                /*for(let j = 0; j < dishesArrForCount.length; j++) {
                    console.log('---' + dishesArrForCount[j]['dish_id'])
                }*/

                for (let key in allDishes) {

                    if (daysIndex.indexOf('' + allDishes[key].id) != -1 || daysIndex.indexOf(allDishes[key].id) != -1) {

                        // Считаю количество блюд для заказа, который уже существует
                        let count = 0;

                        if (typeof dishesArrForCount !== 'undefined') {
                            for (let j = 0; j < +dishesArrForCount.length; j++) {
                                if (+dishesArrForCount[j]['dish_id'] == +allDishes[key].id) {
                                    count++;
                                }
                            }
                        }

                        arr.push({
                            id: i,
                            db_id: allDishes[key].id, // id блюда из бд
                            name: allDishes[key].name,
                            weight: allDishes[key].weight,
                            price: allDishes[key].price,
                            composition: allDishes[key].composition,
                            showComposition: false,
                            // requirement_id: dishes[key].requirement_id,
                            type_id: allDishes[key].type_id,
                            image_link: allDishes[key].image_link,
                            created_at: allDishes[key].created_at,
                            updated_at: allDishes[key].updated_at,
                            count: count,
                            // image: 'soup.svg'
                        });

                        i++;
                    }
                }

                return arr;
            },

            getAllDishesFromStore: function () {
                this.$axios.get('/get-dishes')
                    .then((response) => {

                        // узнаём индексы под которым хранятся данные для всех дней недели
                        let mondayIndex = +this.existOrdersDates.indexOf(this.$store.state.orderWeekDates[1]['год'] + '-' + this.$store.state.orderWeekDates[1]['месяц'] + '-' + this.$store.state.orderWeekDates[1]['число']);
                        let tuesdayIndex = +this.existOrdersDates.indexOf(this.$store.state.orderWeekDates[2]['год'] + '-' + this.$store.state.orderWeekDates[2]['месяц'] + '-' + this.$store.state.orderWeekDates[2]['число']);
                        let wednesdayIndex = +this.existOrdersDates.indexOf(this.$store.state.orderWeekDates[3]['год'] + '-' + this.$store.state.orderWeekDates[3]['месяц'] + '-' + this.$store.state.orderWeekDates[3]['число']);
                        let thursdayIndex = +this.existOrdersDates.indexOf(this.$store.state.orderWeekDates[4]['год'] + '-' + this.$store.state.orderWeekDates[4]['месяц'] + '-' + this.$store.state.orderWeekDates[4]['число']);
                        let fridayIndex = +this.existOrdersDates.indexOf(this.$store.state.orderWeekDates[5]['год'] + '-' + this.$store.state.orderWeekDates[5]['месяц'] + '-' + this.$store.state.orderWeekDates[5]['число']);

                        let dishesArrMonday = this.existOrdersDishes[mondayIndex];
                        let dishesArrTuesday = this.existOrdersDishes[tuesdayIndex];
                        let dishesArrWednesday = this.existOrdersDishes[wednesdayIndex];
                        let dishesArrThursday = this.existOrdersDishes[thursdayIndex];
                        let dishesArrFriday = this.existOrdersDishes[fridayIndex];

                        // учитываем деньги потраченные в заказе
                        let mondayBalance = this.existOrderSums[mondayIndex];
                        let tuesdayBalance = this.existOrderSums[tuesdayIndex];
                        let wednesdayBalance = this.existOrderSums[wednesdayIndex];
                        let thursdayBalance = this.existOrderSums[thursdayIndex];
                        let fridayBalance = this.existOrderSums[fridayIndex];


                        // учёт корпоративных средств
                        if (typeof mondayBalance === 'undefined') {
                            mondayBalance = 0;
                            this.$set(this.$store.state.total, 0, Math.round((mondayBalance) * 100) / 100);
                        } else if (mondayBalance > this.$store.state.initialBalance) {
                            this.$set(this.$store.state.total, 0, Math.round((mondayBalance) * 100) / 100);
                            mondayBalance = this.$store.state.initialBalance;
                        } else {
                            this.$set(this.$store.state.total, 0, Math.round((mondayBalance) * 100) / 100);
                        }

                        if (typeof tuesdayBalance === 'undefined') {
                            tuesdayBalance = 0;
                            this.$set(this.$store.state.total, 1, Math.round((tuesdayBalance) * 100) / 100);
                        } else if (tuesdayBalance > this.$store.state.initialBalance) {
                            this.$set(this.$store.state.total, 1, Math.round((tuesdayBalance) * 100) / 100);
                            tuesdayBalance = this.$store.state.initialBalance;
                        } else {
                            this.$set(this.$store.state.total, 1, Math.round((tuesdayBalance) * 100) / 100);
                        }

                        if (typeof wednesdayBalance === 'undefined') {
                            wednesdayBalance = 0;
                            this.$set(this.$store.state.total, 2, Math.round((wednesdayBalance) * 100) / 100);
                        } else if (wednesdayBalance > this.$store.state.initialBalance) {
                            this.$set(this.$store.state.total, 2, Math.round((wednesdayBalance) * 100) / 100);
                            wednesdayBalance = this.$store.state.initialBalance;
                        } else {
                            this.$set(this.$store.state.total, 2, Math.round((wednesdayBalance) * 100) / 100);
                        }

                        if (typeof thursdayBalance === 'undefined') {
                            thursdayBalance = 0;
                            this.$set(this.$store.state.total, 3, Math.round((thursdayBalance) * 100) / 100);
                        } else if (thursdayBalance > this.$store.state.initialBalance) {
                            this.$set(this.$store.state.total, 3, Math.round((thursdayBalance) * 100) / 100);
                            thursdayBalance = this.$store.state.initialBalance;
                        } else {
                            this.$set(this.$store.state.total, 3, Math.round((thursdayBalance) * 100) / 100);
                        }

                        if (typeof fridayBalance === 'undefined') {
                            fridayBalance = 0;
                            this.$set(this.$store.state.total, 4, Math.round((fridayBalance) * 100) / 100);
                        } else if (fridayBalance > this.$store.state.initialBalance) {
                            this.$set(this.$store.state.total, 4, Math.round((fridayBalance) * 100) / 100);
                            fridayBalance = this.$store.state.initialBalance;
                        } else {
                            this.$set(this.$store.state.total, 4, Math.round((fridayBalance) * 100) / 100);
                        }


                        // использовано личных средств
                        if (+this.$store.state.total[0] > +this.$store.state.initialBalance) {
                            this.$set(this.$store.state.usedPersonalBalance, 0, Math.round((+this.$store.state.total[0] - +this.$store.state.initialBalance) * 100) / 100);
                        } else {
                            this.$set(this.$store.state.usedPersonalBalance, 0, 0);
                        }

                        if (+this.$store.state.total[1] > +this.$store.state.initialBalance) {
                            this.$set(this.$store.state.usedPersonalBalance, 1, Math.round((+this.$store.state.total[1] - +this.$store.state.initialBalance) * 100) / 100);
                        } else {
                            this.$set(this.$store.state.usedPersonalBalance, 1, 0);
                        }

                        if (+this.$store.state.total[2] > +this.$store.state.initialBalance) {
                            this.$set(this.$store.state.usedPersonalBalance, 2, Math.round((+this.$store.state.total[2] - +this.$store.state.initialBalance) * 100) / 100);
                        } else {
                            this.$set(this.$store.state.usedPersonalBalance, 2, 0);
                        }

                        if (+this.$store.state.total[3] > +this.$store.state.initialBalance) {
                            this.$set(this.$store.state.usedPersonalBalance, 3, Math.round((+this.$store.state.total[3] - +this.$store.state.initialBalance) * 100) / 100);
                        } else {
                            this.$set(this.$store.state.usedPersonalBalance, 3, 0);
                        }

                        if (+this.$store.state.total[4] > +this.$store.state.initialBalance) {
                            this.$set(this.$store.state.usedPersonalBalance, 4, Math.round((+this.$store.state.total[4] - +this.$store.state.initialBalance) * 100) / 100);
                        } else {
                            this.$set(this.$store.state.usedPersonalBalance, 4, 0);
                        }


                        // остаток корпоративных средств
                        this.$set(this.$store.state.balance, 0, Math.round((this.$store.state.initialBalance - mondayBalance) * 100) / 100);
                        this.$set(this.$store.state.balance, 1, Math.round((this.$store.state.initialBalance - tuesdayBalance) * 100) / 100);
                        this.$set(this.$store.state.balance, 2, Math.round((this.$store.state.initialBalance - wednesdayBalance) * 100) / 100);
                        this.$set(this.$store.state.balance, 3, Math.round((this.$store.state.initialBalance - thursdayBalance) * 100) / 100);
                        this.$set(this.$store.state.balance, 4, Math.round((this.$store.state.initialBalance - fridayBalance) * 100) / 100);

                        this.$store.state.dishes = response.data;
                        // this.dishes = response.data;
                        this.tableDataMonday = this.sortDishesByDays(this.$store.state.daysForDishes['понедельник'], this.$store.state.dishes, dishesArrMonday);
                        this.tableDataTuesday = this.sortDishesByDays(this.$store.state.daysForDishes['вторник'], this.$store.state.dishes, dishesArrTuesday);
                        this.tableDataWednesday = this.sortDishesByDays(this.$store.state.daysForDishes['среда'], this.$store.state.dishes, dishesArrWednesday);
                        this.tableDataThursday = this.sortDishesByDays(this.$store.state.daysForDishes['четверг'], this.$store.state.dishes, dishesArrThursday);
                        this.tableDataFriday = this.sortDishesByDays(this.$store.state.daysForDishes['пятница'], this.$store.state.dishes, dishesArrFriday);

                        // Передаём информацию об уже заказанных блюдах в массив this.dishesOrder[this.orderDay].push(argTableDataDay[index - 1].db_id);
                        if (typeof dishesArrMonday !== 'undefined') {
                            this.dishesOrder[0].length = 0;

                            for (let i = 0; i < dishesArrMonday.length; i++) {
                                this.dishesOrder[0].push(dishesArrMonday[i]['dish_id']);
                            }
                        }

                        if (typeof dishesArrTuesday !== 'undefined') {
                            this.dishesOrder[1].length = 0;

                            for (let i = 0; i < dishesArrTuesday.length; i++) {
                                this.dishesOrder[1].push(dishesArrTuesday[i]['dish_id']);
                            }
                        }

                        if (typeof dishesArrWednesday !== 'undefined') {
                            this.dishesOrder[2].length = 0;
                            for (let i = 0; i < dishesArrWednesday.length; i++) {
                                this.dishesOrder[2].push(dishesArrWednesday[i]['dish_id']);
                            }
                        }

                        if (typeof dishesArrThursday !== 'undefined') {
                            this.dishesOrder[3].length = 0;
                            for (let i = 0; i < dishesArrThursday.length; i++) {
                                this.dishesOrder[3].push(dishesArrThursday[i]['dish_id']);
                            }
                        }

                        if (typeof dishesArrFriday !== 'undefined') {
                            this.dishesOrder[4].length = 0;
                            for (let i = 0; i < dishesArrFriday.length; i++) {
                                this.dishesOrder[4].push(dishesArrFriday[i]['dish_id']);
                            }
                        }

                        // Учёт данных по посуде из уже оформленных заказов
                        // existOrdersDishesTypes

                        let dishesArr = [];
                        let index = 0;

                        for (let $day = 0; $day < 5; $day++) {

                            if ($day == 0) {
                                dishesArr = dishesArrMonday;
                                index = mondayIndex;
                            } else if ($day == 1) {
                                dishesArr = dishesArrTuesday;
                                index = tuesdayIndex;
                            } else if ($day == 2) {
                                dishesArr = dishesArrWednesday;
                                index = wednesdayIndex;
                            } else if ($day == 3) {
                                dishesArr = dishesArrThursday;
                                index = thursdayIndex;
                            } else if ($day == 4) {
                                dishesArr = dishesArrFriday;
                                index = fridayIndex;
                            }


                            if (typeof dishesArr !== 'undefined') {
                                let spoons = 0;
                                let firstDishes = 0;
                                let garnishes = [];
                                let meats = [];
                                let forks = 0;
                                let salads = 0;

                                for (let i = 0; i < this.existOrdersDishesTypes[index].length; i++) {
                                    if (+this.existOrdersDishesTypes[index][i]['type_id'] == 1) { // первое
                                        spoons++;
                                        firstDishes++;
                                    } else if (+this.existOrdersDishesTypes[index][i]['type_id'] == 2) { // гарнир
                                        forks++;
                                        garnishes.push(dishesArr[i]['dish_id']);
                                    } else if (+this.existOrdersDishesTypes[index][i]['type_id'] == 3) { // мясное
                                        forks++;
                                        meats.push(dishesArr[i]['dish_id']);
                                    } else if (+this.existOrdersDishesTypes[index][i]['type_id'] == 4) { // салат
                                        forks++;
                                        salads++;
                                    }

                                }

                                /////////////
                                let unique = this.getUniqueArray(garnishes);

                                let garnishNum = [];
                                for (let i = 0; i < unique.length; i++) {
                                    garnishNum[i] = 0;

                                    for (let j = 0; j < garnishes.length; j++) {
                                        if (+unique[i] == +garnishes[j]) {
                                            garnishNum[i]++;
                                        }
                                    }

                                    if (garnishNum[i] % 2 == 0) { // число блюд чётное, их можно расфосовать по ДВА в тару
                                        // считаем количество тары для данного гарнира
                                        garnishNum[i] = garnishNum[i] / 2;
                                    } else {
                                        // считаем количество тары для данного гарнира
                                        garnishNum[i] = Math.ceil(garnishNum[i] / 2);
                                    }
                                }

                                let numTara = 0;
                                for (let j = 0; j < garnishNum.length; j++) {
                                    numTara += garnishNum[j];
                                }

                                this.$set(this.numberForGarnishTara, $day, numTara);

                                // Считаем сколько надо посуды для каждого уникального блюда (мясное)
                                // this.meatIds[this.orderDay] = this.removeElementFromArray(this.meatIds[this.orderDay], argTableDataDay[index - 1].db_id); // Удаляем id блюда от которого отказались
                                unique = this.getUniqueArray(meats);

                                let meatNum = [];
                                for (let i = 0; i < unique.length; i++) {
                                    meatNum[i] = 0;

                                    for (let j = 0; j < meats.length; j++) {
                                        if (+unique[i] == +meats[j]) {
                                            meatNum[i]++;
                                        }
                                    }

                                    if (meatNum[i] % 2 == 0) { // число блюд чётное, их можно расфосовать по ДВА в тару
                                        // считаем количество тары для данного гарнира
                                        meatNum[i] = meatNum[i] / 2;
                                    } else {
                                        // считаем количество тары для данного гарнира
                                        meatNum[i] = Math.ceil(meatNum[i] / 2);
                                    }
                                }

                                numTara = 0;
                                for (let j = 0; j < meatNum.length; j++) {
                                    numTara += meatNum[j];
                                }

                                this.$set(this.numberForMeatTara, $day, numTara);
                                // }


                                // Совмещаем гарниры и мясное в общей таре
                                if (this.numberForGarnishTara[$day] >= this.numberForMeatTara[$day]) { // Если гарниров больше, чем мяса (или столько же) - ложим всё к гарнирам
                                    this.$set(this.numberForGarnishOrMeatTara, $day, this.numberForGarnishTara[$day]);
                                } else if (this.numberForGarnishTara[$day] < this.numberForMeatTara[$day]) {
                                    this.$set(this.numberForGarnishOrMeatTara, $day, this.numberForMeatTara[$day]);
                                }
                                /////////////

                                this.$set(this.numberForSpoon, $day, spoons);

                                this.$set(this.numberForFork, $day, forks);
                                this.$set(this.numberForSaladTara, $day, salads);
                            }
                        }


                        // existOrdersDishesTypes
                        /*if(typeof dishesArrMonday !== 'undefined') {
                            let spoons = 0;
                            let firstDishes = 0;
                            let garnishes = [];
                            let meats = [];
                            let forks = 0;
                            let salads = 0;

                            for(let i = 0; i < this.existOrdersDishesTypes[mondayIndex].length; i++) {
                                if(+this.existOrdersDishesTypes[mondayIndex][i]['type_id'] == 1) { // первое
                                    spoons++;
                                    firstDishes++;
                                } else if(+this.existOrdersDishesTypes[mondayIndex][i]['type_id'] == 2) { // гарнир
                                    forks++;
                                    garnishes.push(dishesArrMonday[i]['dish_id']);
                                } else if(+this.existOrdersDishesTypes[mondayIndex][i]['type_id'] == 3) { // мясное
                                    forks++;
                                    meats.push(dishesArrMonday[i]['dish_id']);
                                } else if(+this.existOrdersDishesTypes[mondayIndex][i]['type_id'] == 4) { // салат
                                    forks++;
                                    salads++;
                                }

                            }

                            /////////////
                            let unique = this.getUniqueArray(garnishes);

                            let garnishNum = [];
                            for (let i = 0; i < unique.length; i++) {
                                garnishNum[i] = 0;

                                for (let j = 0; j < garnishes.length; j++) {
                                    if (+unique[i] == +garnishes[j]) {
                                        garnishNum[i]++;
                                    }
                                }

                                if (garnishNum[i] % 2 == 0) { // число блюд чётное, их можно расфосовать по ДВА в тару
                                    // считаем количество тары для данного гарнира
                                    garnishNum[i] = garnishNum[i] / 2;
                                } else {
                                    // считаем количество тары для данного гарнира
                                    garnishNum[i] = Math.ceil(garnishNum[i] / 2);
                                }
                            }

                            let numTara = 0;
                            for (let j = 0; j < garnishNum.length; j++) {
                                numTara += garnishNum[j];
                            }

                            this.$set(this.numberForGarnishTara, 0, numTara);

                            // Считаем сколько надо посуды для каждого уникального блюда (мясное)
                            // this.meatIds[this.orderDay] = this.removeElementFromArray(this.meatIds[this.orderDay], argTableDataDay[index - 1].db_id); // Удаляем id блюда от которого отказались
                            unique = this.getUniqueArray(meats);

                            let meatNum = [];
                            for (let i = 0; i < unique.length; i++) {
                                meatNum[i] = 0;

                                for (let j = 0; j < meats.length; j++) {
                                    if (+unique[i] == +meats[j]) {
                                        meatNum[i]++;
                                    }
                                }

                                if (meatNum[i] % 2 == 0) { // число блюд чётное, их можно расфосовать по ДВА в тару
                                    // считаем количество тары для данного гарнира
                                    meatNum[i] = meatNum[i] / 2;
                                } else {
                                    // считаем количество тары для данного гарнира
                                    meatNum[i] = Math.ceil(meatNum[i] / 2);
                                }
                            }

                            numTara = 0;
                            for (let j = 0; j < meatNum.length; j++) {
                                numTara += meatNum[j];
                            }

                            this.$set(this.numberForMeatTara, 0, numTara);
                            // }


                            // Совмещаем гарниры и мясное в общей таре
                            if (this.numberForGarnishTara[0] >= this.numberForMeatTara[0]) { // Если гарниров больше, чем мяса (или столько же) - ложим всё к гарнирам
                                this.$set(this.numberForGarnishOrMeatTara, 0, this.numberForGarnishTara[0]);
                            } else if (this.numberForGarnishTara[0] < this.numberForMeatTara[0]) {
                                this.$set(this.numberForGarnishOrMeatTara, 0, this.numberForMeatTara[0]);
                            }
                            /////////////

                            this.$set(this.numberForSpoon, 0, spoons);

                            this.$set(this.numberForFork, 0, forks);
                            this.$set(this.numberForSaladTara, 0, salads);
                        }*/


                    }).catch((err) => {
                    console.log('Ошибка ' + err)
                })
            },


            getDay: function (index, dayForOrder) {
                // console.log('_____333');

                //index - день недели отображения меню
                //orderDay - текущий день недели
                //нумерация дней с 0

                //передаём в хранилище день показа меню на выбранный день
                this.$store.state.orderDay = dayForOrder;
            },

            getObjectFromArrayByProperty: function (array, property_name, property_value) { // возращает номер элемента массива объектов с заданным свойством
                // console.log('_____444');
                for (let i = 0; i < array.length; i++) {
                    if (array[i][property_name] == property_value) {
                        return i;
                    }
                }
            },

            removeElementFromArray: function (arr, value) { // удаляет из массива элемент по его значению
                // console.log('_____555');
                let index = arr.indexOf(value);

                if (index > -1) {
                    arr.splice(index, 1);
                }

                return arr;
            },

            getUniqueArray: function (arr) {
                let uniqueArray = [];

                for (let i = 0; i < arr.length; i++) {
                    if (uniqueArray.indexOf(arr[i]) == -1) {
                        uniqueArray.push(arr[i]);
                    }
                }

                return uniqueArray;
            },

            addDishToOrder: function (index, argTableDataDay) { // index - позиция блюда в таблице qTable, argTableDataDay - массив с блюдами доступными на выбранный день
                // console.log('_____666 index, ' + index + ', index ' + argTableDataDay);

                let typeIndex = this.getObjectFromArrayByProperty(this.dishesTypes, 'id', argTableDataDay[index - 1].type_id);
                let balanceForArray = 0; // this.$set(this.showAllDishes, this.orderDay, true);

                // расчёт стоимости для первого блюда 121
                if (this.dishesTypes[typeIndex].name == 'первое') { // 1111
                    let spoonIndex = this.getObjectFromArrayByProperty(this.requirements, 'name', 'Ложка');
                    let spoonPrice = this.requirements[spoonIndex].price;

                    let taraIndex = this.getObjectFromArrayByProperty(this.requirements, 'name', 'Банка под первое блюдо');
                    let taraPrice = this.requirements[taraIndex].price;

                    if (+this.$store.state.balance[this.orderDay] >= (+argTableDataDay[index - 1].price + +taraPrice + +spoonPrice)) { // сначала используем для оплаты баланс пользователя
                        argTableDataDay[index - 1].count++;

                        balanceForArray = +this.$store.state.balance[this.orderDay];
                        balanceForArray -= (+argTableDataDay[index - 1].price + +taraPrice + +spoonPrice);
                        this.$set(this.$store.state.balance, this.orderDay, Math.round((balanceForArray) * 100) / 100);

                        let total = this.$store.state.total[this.orderDay];
                        total += (+argTableDataDay[index - 1].price + +taraPrice + +spoonPrice);
                        this.$set(this.$store.state.total, this.orderDay, Math.abs(total)); // расчёт суммарно потраченных средств

                        this.numberForSpoon[this.orderDay]++;
                        this.$set(this.numberForSpoon, this.orderDay, this.numberForSpoon[this.orderDay]);

                        this.dishesOrder[this.orderDay].push(argTableDataDay[index - 1].db_id); // сохранение id выбранного блюда в массиве с информацией о заказе
                    } else if ((+this.$store.state.personalBalance - +this.usedPersonalBalance[this.orderDay] + +this.$store.state.balance[this.orderDay]) >= (+argTableDataDay[index - 1].price + +taraPrice + +spoonPrice)) { // если его не хватает - используем личные средства
                        balanceForArray = +this.$store.state.balance[this.orderDay];
                        this.$set(this.$store.state.balance, this.orderDay, Math.round((balanceForArray) * 100) / 100);
                        this.$store.state.personalBalance += +this.$store.state.balance[this.orderDay]; // закидываем остаток балансв в личные средства
                        this.$set(this.$store.state.balance, this.orderDay, 0); // обнуляем баланс

                        argTableDataDay[index - 1].count++;
                        this.$store.state.personalBalance -= (+argTableDataDay[index - 1].price + +taraPrice + +spoonPrice);

                        let total = this.$store.state.total[this.orderDay];
                        total += (+argTableDataDay[index - 1].price + +taraPrice + +spoonPrice);
                        this.$set(this.$store.state.total, this.orderDay, Math.abs(total)); // расчёт суммарно потраченных средств

                        this.$set(this.$store.state.usedPersonalBalance, this.orderDay, Math.abs(total - this.$store.state.initialBalance)); // расчёт потраченных личных средств

                        this.numberForSpoon[this.orderDay]++;
                        this.$set(this.numberForSpoon, this.orderDay, this.numberForSpoon[this.orderDay]);

                        this.dishesOrder[this.orderDay].push(argTableDataDay[index - 1].db_id); // сохранение id выбранного блюда в массиве с информацией о заказе
                    } else {
                        this.$refs.showNotify.showNotify('Недостаточно средств! Пожалуйста, выберите другие блюда или уменьшите количество блюд в заказе!');
                    }

                }

                // расчёт стоимости для салатов
                else if (this.dishesTypes[typeIndex].name == 'салат') {
                    let forkIndex = this.getObjectFromArrayByProperty(this.requirements, 'name', 'Вилка');
                    let forkPrice = 0;

                    if (this.numberForFork[this.orderDay] == 0) { // если заказываем блюдо в первый раз и кухонных принадлежностей (вилки) ещё нет
                        forkPrice = this.requirements[forkIndex].price;
                    } else { // если кухонные принадлежности (вилка) уже есть - их стоимость считать не надо
                        forkPrice = 0;
                    }

                    let taraIndex = this.getObjectFromArrayByProperty(this.requirements, 'name', 'Контейнер для салата');
                    let taraPrice = this.requirements[taraIndex].price;

                    // console.log('тара для салата ' + taraIndex + ' ' + taraPrice);

                    if (+this.$store.state.balance[this.orderDay] >= (+argTableDataDay[index - 1].price + +taraPrice + +forkPrice)) { // сначала используем для оплаты баланс пользователя
                        // if (+this.$store.state.personalBalance >= (+argTableDataDay[index - 1].price + +taraPrice + +forkPrice)) { // сначала используем для оплаты баланс пользователя
                        argTableDataDay[index - 1].count++;

                        balanceForArray = +this.$store.state.balance[this.orderDay];
                        balanceForArray -= (+argTableDataDay[index - 1].price + +taraPrice + +forkPrice);
                        this.$set(this.$store.state.balance, this.orderDay, Math.round((balanceForArray) * 100) / 100);

                        let total = this.$store.state.total[this.orderDay];
                        total += (+argTableDataDay[index - 1].price + +taraPrice + +forkPrice);
                        this.$set(this.$store.state.total, this.orderDay, Math.abs(total)); // расчёт суммарно потраченных средств

                        this.numberForFork[this.orderDay]++;
                        this.$set(this.numberForFork, this.orderDay, this.numberForFork[this.orderDay]);

                        this.numberForSaladTara[this.orderDay]++;
                        this.$set(this.numberForSaladTara, this.orderDay, this.numberForSaladTara[this.orderDay]);

                        this.dishesOrder[this.orderDay].push(argTableDataDay[index - 1].db_id); // сохранение id выбранного блюда в массиве с информацией о заказе
                    } else if ((+this.$store.state.personalBalance - +this.usedPersonalBalance[this.orderDay] + +this.$store.state.balance[this.orderDay]) >= (+argTableDataDay[index - 1].price + +taraPrice + +forkPrice)) { // если его не хватает - используем личные средства
                        balanceForArray = +this.$store.state.balance[this.orderDay];
                        this.$set(this.$store.state.balance, this.orderDay, Math.round((balanceForArray) * 100) / 100);
                        this.$store.state.personalBalance += +this.$store.state.balance[this.orderDay]; // закидываем остаток балансв в личные средства
                        this.$set(this.$store.state.balance, this.orderDay, 0); // обнуляем баланс

                        argTableDataDay[index - 1].count++;
                        this.$store.state.personalBalance -= (+argTableDataDay[index - 1].price + +taraPrice + +forkPrice);

                        let total = this.$store.state.total[this.orderDay];
                        total += (+argTableDataDay[index - 1].price + +taraPrice + +forkPrice);
                        this.$set(this.$store.state.total, this.orderDay, Math.abs(total)); // расчёт суммарно потраченных средств

                        this.$set(this.$store.state.usedPersonalBalance, this.orderDay, Math.abs(total - this.$store.state.initialBalance)); // расчёт потраченных личных средств

                        this.numberForFork[this.orderDay]++;
                        this.$set(this.numberForFork, this.orderDay, this.numberForFork[this.orderDay]);

                        this.numberForSaladTara[this.orderDay]++;
                        this.$set(this.numberForSaladTara, this.orderDay, this.numberForSaladTara[this.orderDay]);

                        this.dishesOrder[this.orderDay].push(argTableDataDay[index - 1].db_id); // сохранение id выбранного блюда в массиве с информацией о заказе
                    } else {
                        this.$refs.showNotify.showNotify('Недостаточно средств! Пожалуйста, выберите другие блюда или уменьшите количество блюд в заказе!');
                    }
                }

                // расчёт стоимости для гарнира и мяса 221
                else if (this.dishesTypes[typeIndex].name == 'гарнир' || this.dishesTypes[typeIndex].name == 'мясо') {
                    let forkIndex = this.getObjectFromArrayByProperty(this.requirements, 'name', 'Вилка');
                    let forkPrice = 0;

                    if (this.numberForFork[this.orderDay] == 0) { // если заказываем блюдо в первый раз и кухонных принадлежностей (вилки) ещё нет
                        forkPrice = this.requirements[forkIndex].price;
                    } else { // если кухонные принадлежности (вилка) уже есть - их стоимость считать не надо
                        forkPrice = 0;
                    }

                    let taraIndex = this.getObjectFromArrayByProperty(this.requirements, 'name', 'Контейнер под мясное блюдо и гарнир');
                    let taraPrice = this.requirements[taraIndex].price;
                    let taraStartNumber = this.numberForGarnishOrMeatTara[this.orderDay]; // Количество тары под гарнир и/или мясо до заказа нового блюда (для расчёта цены)
                    let taraEndNumber = 0; // Количество тары под гарнир и/или мясо после заказа нового блюда (для расчёта цены)
                    let garnishTaraStartNumber = this.numberForGarnishTara[this.orderDay]; // Количество тары под гарнир до заказа нового блюда (для расчёта цены)
                    let meatTaraStartNumber = this.numberForMeatTara[this.orderDay]; // Количество тары под мясоное до заказа нового блюда (для расчёта цены)


                    // расчёт количества тары
                    if (this.dishesTypes[typeIndex].name == 'гарнир') {

                        if (+this.garnishIds[this.orderDay].indexOf(+argTableDataDay[index - 1].db_id) == -1) { // если такого гарнира ещё нет, то заказываем новую тару
                            this.garnishIds[this.orderDay].push(+argTableDataDay[index - 1].db_id); // сохраняем выбранный гарнир

                            this.numberForGarnishOrMeatTara[this.orderDay]++; // добавляем новую тару
                            this.$set(this.numberForGarnishOrMeatTara, this.orderDay, this.numberForGarnishOrMeatTara[this.orderDay]);

                            this.numberForGarnishTara[this.orderDay]++; // запоминаем количество тары с гарниром
                            this.$set(this.numberForGarnishTara, this.orderDay, this.numberForGarnishTara[this.orderDay]);
                        } else { // если блюдо есть, то надо определить сколько порций уже заказали
                            let num = 0;

                            for (let i = 0; i < this.garnishIds[this.orderDay].length; i++) {

                                if (+this.garnishIds[this.orderDay][i] == +argTableDataDay[index - 1].db_id) {
                                    num++;
                                }
                            }

                            this.garnishIds[this.orderDay].push(+argTableDataDay[index - 1].db_id); // сохраняем выбранный гарнир

                            if (num % 2 == 0) { // число блюд чётное, т.е. они уже расфасофаны по 2 блюда в тару, для текущего блюда нужна новая
                                this.numberForGarnishOrMeatTara[this.orderDay]++; // добавляем новую тару
                                this.$set(this.numberForGarnishOrMeatTara, this.orderDay, this.numberForGarnishOrMeatTara[this.orderDay]);

                                this.numberForGarnishTara[this.orderDay]++; // запоминаем количество тары с гарниром
                                this.$set(this.numberForGarnishTara, this.orderDay, this.numberForGarnishTara[this.orderDay]);
                            }
                        }

                        // taraEndNumber = this.numberForGarnishOrMeatTara[this.orderDay];

                    } else if (this.dishesTypes[typeIndex].name == 'мясо') {

                        if (+this.meatIds[this.orderDay].indexOf(+argTableDataDay[index - 1].db_id) == -1) { // если такого мясного ещё нет, то заказываем новую тару
                            this.meatIds[this.orderDay].push(+argTableDataDay[index - 1].db_id); // сохраняем выбранный гарнир

                            this.numberForGarnishOrMeatTara[this.orderDay]++; // добавляем новую тару
                            this.$set(this.numberForGarnishOrMeatTara, this.orderDay, this.numberForGarnishOrMeatTara[this.orderDay]);

                            this.numberForMeatTara[this.orderDay]++; // запоминаем количество тары с гарниром
                            this.$set(this.numberForMeatTara, this.orderDay, this.numberForMeatTara[this.orderDay]);
                        } else { // если блюдо есть, то надо определить сколько порций уже заказали
                            let num = 0;

                            for (let i = 0; i < this.meatIds[this.orderDay].length; i++) {

                                if (+this.meatIds[this.orderDay][i] == +argTableDataDay[index - 1].db_id) {
                                    num++;
                                }
                            }

                            this.meatIds[this.orderDay].push(+argTableDataDay[index - 1].db_id); // сохраняем выбранное мясное

                            if (num % 2 == 0) { // число блюд чётное, т.е. они уже расфасофаны по 2 блюда в тару, для текущего блюда нужна новая
                                this.numberForGarnishOrMeatTara[this.orderDay]++; // добавляем новую тару
                                this.$set(this.numberForGarnishOrMeatTara, this.orderDay, this.numberForGarnishOrMeatTara[this.orderDay]);

                                this.numberForMeatTara[this.orderDay]++; // запоминаем количество тары с мясным
                                this.$set(this.numberForMeatTara, this.orderDay, this.numberForMeatTara[this.orderDay]);
                            }
                        }

                        // taraEndNumber = this.numberForGarnishOrMeatTara[this.orderDay];
                    }

                    // Совмещаем гарниры и мясное в общей таре
                    if (this.numberForGarnishTara >= this.numberForMeatTara) { // Если гарниров больше, чем мяса (или столько же) - ложим всё к гарнирам
                        this.$set(this.numberForGarnishOrMeatTara, this.orderDay, this.numberForGarnishTara[this.orderDay]);
                    } else {
                        this.$set(this.numberForGarnishOrMeatTara, this.orderDay, this.numberForMeatTara[this.orderDay]);
                    }

                    taraEndNumber = this.numberForGarnishOrMeatTara[this.orderDay];
                    taraPrice = taraPrice * (taraEndNumber - taraStartNumber);
                    // taraPrice = 0;

                    // if (+this.$store.state.personalBalance >= (+argTableDataDay[index - 1].price + +taraPrice + +forkPrice)) { // сначала используем для оплаты баланс пользователя
                    if (+this.$store.state.balance[this.orderDay] >= (+argTableDataDay[index - 1].price + +taraPrice + +forkPrice)) { // сначала используем для оплаты баланс пользователя
                        argTableDataDay[index - 1].count++;
                        balanceForArray = +this.$store.state.balance[this.orderDay];
                        balanceForArray -= (+argTableDataDay[index - 1].price + +taraPrice + +forkPrice);
                        this.$set(this.$store.state.balance, this.orderDay, Math.round((balanceForArray) * 100) / 100);

                        let total = this.$store.state.total[this.orderDay];
                        total += (+argTableDataDay[index - 1].price + +taraPrice + +forkPrice);
                        this.$set(this.$store.state.total, this.orderDay, Math.abs(total)); // расчёт суммарно потраченных средств

                        this.numberForFork[this.orderDay]++;
                        this.$set(this.numberForFork, this.orderDay, this.numberForFork[this.orderDay]);

                        this.dishesOrder[this.orderDay].push(argTableDataDay[index - 1].db_id); // сохранение id выбранного блюда в массиве с информацией о заказе
                    } else if ((+this.$store.state.personalBalance - +this.usedPersonalBalance[this.orderDay] + +this.$store.state.balance[this.orderDay]) >= (+argTableDataDay[index - 1].price + +taraPrice + +forkPrice)) { // если его не хватает - используем личные средства
                        balanceForArray = +this.$store.state.balance[this.orderDay];
                        this.$set(this.$store.state.balance, this.orderDay, Math.round((balanceForArray) * 100) / 100);
                        this.$store.state.personalBalance += +this.$store.state.balance[this.orderDay]; // закидываем остаток балансв в личные средства
                        this.$set(this.$store.state.balance, this.orderDay, 0); // обнуляем баланс

                        argTableDataDay[index - 1].count++;
                        this.$store.state.personalBalance -= (+argTableDataDay[index - 1].price + +taraPrice + +forkPrice);

                        let total = this.$store.state.total[this.orderDay];
                        total += (+argTableDataDay[index - 1].price + +taraPrice + +forkPrice);
                        this.$set(this.$store.state.total, this.orderDay, Math.abs(total)); // расчёт суммарно потраченных средств

                        this.$set(this.$store.state.usedPersonalBalance, this.orderDay, Math.abs(total - this.$store.state.initialBalance)); // расчёт потраченных личных средств

                        this.numberForFork[this.orderDay]++;
                        this.$set(this.numberForFork, this.orderDay, this.numberForFork[this.orderDay]);

                        this.dishesOrder[this.orderDay].push(argTableDataDay[index - 1].db_id); // сохранение id выбранного блюда в массиве с информацией о заказе
                    } else { // если средств на заказ блюда не хватило, то надо вернуть исходные значения количества выбранных блюд и тары
                        this.$set(this.numberForGarnishOrMeatTara, this.orderDay, taraStartNumber);
                        this.$set(this.numberForGarnishTara, this.orderDay, garnishTaraStartNumber);
                        this.$set(this.numberForMeatTara, this.orderDay, meatTaraStartNumber);


                        if (this.dishesTypes[typeIndex].name == 'гарнир') { // удаляем id гарнира на который не хватило денег
                            this.garnishIds[this.orderDay] = this.removeElementFromArray(this.garnishIds[this.orderDay], argTableDataDay[index - 1].db_id);
                        } else { // удаляем id мясного на которое не хватило денег
                            this.meatIds[this.orderDay] = this.removeElementFromArray(this.meatIds[this.orderDay], argTableDataDay[index - 1].db_id);
                        }

                        this.$refs.showNotify.showNotify('Недостаточно средств! Пожалуйста, выберите другие блюда или уменьшите количество блюд в заказе!');
                    }
                }

                // расчёт стоимости для блюд без тары, т.е. выпечка
                else if (this.dishesTypes[typeIndex].name == 'выпечка'
                ) {
                    // if (+this.$store.state.personalBalance >= argTableDataDay[index - 1].price) { // сначала используем для оплаты баланс пользователя
                    if (+this.$store.state.balance[this.orderDay] >= argTableDataDay[index - 1].price) { // сначала используем для оплаты баланс пользователя
                        argTableDataDay[index - 1].count++;
                        balanceForArray = +this.$store.state.balance[this.orderDay];
                        balanceForArray -= +argTableDataDay[index - 1].price;
                        this.$set(this.$store.state.balance, this.orderDay, Math.round((balanceForArray) * 100) / 100);

                        let total = this.$store.state.total[this.orderDay];
                        total += (+argTableDataDay[index - 1].price);
                        this.$set(this.$store.state.total, this.orderDay, Math.abs(total)); // расчёт суммарно потраченных средств

                        this.dishesOrder[this.orderDay].push(argTableDataDay[index - 1].db_id); // сохранение id выбранного блюда в массиве с информацией о заказе
                    } else if ((+this.$store.state.personalBalance - +this.usedPersonalBalance[this.orderDay] + +this.$store.state.balance[this.orderDay]) >= (+argTableDataDay[index - 1].price)) { // если его не хватает - используем личные средства
                        balanceForArray = +this.$store.state.balance[this.orderDay];
                        this.$set(this.$store.state.balance, this.orderDay, Math.round((balanceForArray) * 100) / 100);
                        this.$store.state.personalBalance += +this.$store.state.balance[this.orderDay]; // закидываем остаток балансв в личные средства
                        this.$set(this.$store.state.balance, this.orderDay, 0); // обнуляем баланс

                        argTableDataDay[index - 1].count++;
                        this.$store.state.personalBalance -= (+argTableDataDay[index - 1].price);

                        let total = this.$store.state.total[this.orderDay];
                        total += (+argTableDataDay[index - 1].price);
                        this.$set(this.$store.state.total, this.orderDay, Math.abs(total)); // расчёт суммарно потраченных средств

                        this.$set(this.$store.state.usedPersonalBalance, this.orderDay, Math.abs(total - this.$store.state.initialBalance)); // расчёт потраченных личных средств

                        this.dishesOrder[this.orderDay].push(argTableDataDay[index - 1].db_id); // сохранение id выбранного блюда в массиве с информацией о заказе
                    } else {
                        this.$refs.showNotify.showNotify('Недостаточно средств! Пожалуйста, выберите другие блюда или уменьшите количество блюд в заказе!');
                    }
                }
            },

            removeDishFromOrder: function (index, argTableDataDay) {
                // console.log('_____777');
                if (+argTableDataDay[index - 1].count > 0) {
                    let typeIndex = this.getObjectFromArrayByProperty(this.dishesTypes, 'id', argTableDataDay[index - 1].type_id);
                    let balanceForArray = 0;

                    /*let usedPersonalBalanceAtOtherDays = 0;
                    for (let i = 0; i < this.$store.state.usedPersonalBalance.length; i++) {
                        if (i != this.orderDay) {
                            usedPersonalBalanceAtOtherDays += this.$store.state.usedPersonalBalance[i];
                        }
                    }*/

                    // возрат средств для первого блюда 122
                    if (this.dishesTypes[typeIndex].name == 'первое') {

                        this.numberForSpoon[this.orderDay]--;
                        this.$set(this.numberForSpoon, this.orderDay, this.numberForSpoon[this.orderDay]);

                        let spoonIndex = this.getObjectFromArrayByProperty(this.requirements, 'name', 'Ложка');
                        let spoonPrice = this.requirements[spoonIndex].price;

                        let taraIndex = this.getObjectFromArrayByProperty(this.requirements, 'name', 'Банка под первое блюдо');
                        let taraPrice = this.requirements[taraIndex].price;


                        if ((+this.$store.state.total[this.orderDay] - +this.$store.state.initialBalance) > (+argTableDataDay[index - 1].price + +taraPrice + +spoonPrice)) {
                            // console.log(11111);

                            argTableDataDay[index - 1].count--;
                            this.$store.state.personalBalance += (+argTableDataDay[index - 1].price + +taraPrice + +spoonPrice);

                            let total = this.$store.state.total[this.orderDay];
                            total -= (+argTableDataDay[index - 1].price + +taraPrice + +spoonPrice);
                            this.$set(this.$store.state.total, this.orderDay, Math.abs(total)); // расчёт суммарно потраченных средств

                            let usedPersonalBalance = +this.$store.state.usedPersonalBalance[this.orderDay];
                            usedPersonalBalance -= (+argTableDataDay[index - 1].price + +taraPrice + +spoonPrice);

                            /*if (usedPersonalBalance < (+argTableDataDay[index - 1].price + +taraPrice + +spoonPrice)) {
                                usedPersonalBalance = (+argTableDataDay[index - 1].price + +taraPrice + +spoonPrice) - usedPersonalBalance;
                            }*/
                            if (usedPersonalBalance < 0) {
                                usedPersonalBalance = 0;
                            }

                            this.$set(this.$store.state.usedPersonalBalance, this.orderDay, usedPersonalBalance); // расчёт потраченных личных средств

                            let dishesOrderArr = this.removeElementFromArray(this.dishesOrder[this.orderDay], argTableDataDay[index - 1].db_id); // при отмене выбора блюда необходимо убрать его из массива с информацией о заказе
                            this.$set(this.dishesOrder, this.orderDay, dishesOrderArr); // расчёт потраченных личных средств
                        } else {
                            // console.log(22222);

                            let rest = 0; // расчёт остатка при смене условия
                            if (+this.$store.state.total[this.orderDay] > +this.$store.state.initialBalance) {
                                rest = +this.$store.state.total[this.orderDay] - +this.$store.state.initialBalance;
                            } else {
                                rest = 0;
                            }

                            // console.log(22222 + ' ' + rest);

                            argTableDataDay[index - 1].count--;
                            balanceForArray = +this.$store.state.balance[this.orderDay];
                            // balanceForArray += (+argTableDataDay[index - 1].price + +taraPrice + +spoonPrice  - rest + usedPersonalBalanceAtOtherDays);
                            balanceForArray += (+argTableDataDay[index - 1].price + +taraPrice + +spoonPrice - rest);

                            this.$set(this.$store.state.balance, this.orderDay, Math.round((balanceForArray) * 100) / 100);

                            this.$store.state.personalBalance += rest;

                            this.$set(this.$store.state.usedPersonalBalance, this.orderDay, 0); // обнуляем потраченые личные средства

                            let total = this.$store.state.total[this.orderDay];
                            total -= (+argTableDataDay[index - 1].price + +taraPrice + +spoonPrice);
                            this.$set(this.$store.state.total, this.orderDay, Math.abs(total)); // расчёт суммарно потраченных средств

                            let dishesOrderArr = this.removeElementFromArray(this.dishesOrder[this.orderDay], argTableDataDay[index - 1].db_id); // при отмене выбора блюда необходимо убрать его из массива с информацией о заказе
                            this.$set(this.dishesOrder, this.orderDay, dishesOrderArr); // расчёт потраченных личных средств
                        }
                    }

                    // возрат средств для салата
                    else if (this.dishesTypes[typeIndex].name == 'салат') {
                        this.numberForFork[this.orderDay]--; // количество блюд, которые едят вилкой
                        this.$set(this.numberForFork, this.orderDay, this.numberForFork[this.orderDay]);

                        let forkIndex = this.getObjectFromArrayByProperty(this.requirements, 'name', 'Вилка');
                        let forkPrice = 0;

                        if (this.numberForFork[this.orderDay] == 0) { // последняя порция салата, кухонные принадлежности для него не нужны
                            forkPrice = this.requirements[forkIndex].price;
                        } else {
                            forkPrice = 0;
                        }

                        this.numberForSaladTara[this.orderDay]--;
                        this.$set(this.numberForSaladTara, this.orderDay, this.numberForSaladTara[this.orderDay]);

                        let taraIndex = this.getObjectFromArrayByProperty(this.requirements, 'name', 'Контейнер для салата');
                        let taraPrice = this.requirements[taraIndex].price;

                        if ((this.$store.state.total[this.orderDay] - this.$store.state.initialBalance) > (+argTableDataDay[index - 1].price + +taraPrice + +forkPrice)) {

                            argTableDataDay[index - 1].count--;
                            this.$store.state.personalBalance += (+argTableDataDay[index - 1].price + +taraPrice + +forkPrice);

                            let total = this.$store.state.total[this.orderDay];
                            total -= (+argTableDataDay[index - 1].price + +taraPrice + +forkPrice);
                            this.$set(this.$store.state.total, this.orderDay, Math.abs(total)); // расчёт суммарно потраченных средств

                            let usedPersonalBalance = this.$store.state.usedPersonalBalance[this.orderDay];
                            usedPersonalBalance -= (+argTableDataDay[index - 1].price + +taraPrice + +forkPrice);

                            if (usedPersonalBalance < 0) {
                                usedPersonalBalance = 0;
                            }
                            this.$set(this.$store.state.usedPersonalBalance, this.orderDay, usedPersonalBalance); // расчёт потраченных личных средств

                            console.log('if ' + this.$store.state.usedPersonalBalance)

                            // this.dishesOrder[this.orderDay] = this.removeElementFromArray(this.dishesOrder, argTableDataDay[index - 1].db_id); // при отмене выбора блюда необходимо убрать его из массива с информацией о заказе
                            let dishesOrderArr = this.removeElementFromArray(this.dishesOrder[this.orderDay], argTableDataDay[index - 1].db_id); // при отмене выбора блюда необходимо убрать его из массива с информацией о заказе
                            this.$set(this.dishesOrder, this.orderDay, dishesOrderArr); // расчёт потраченных личных средств
                        } else {
                            let rest = 0; // расчёт остатка при смене условия
                            if (+this.$store.state.total[this.orderDay] > +this.$store.state.initialBalance) {
                                rest = +this.$store.state.total[this.orderDay] - +this.$store.state.initialBalance;
                            } else {
                                rest = 0;
                            }

                            argTableDataDay[index - 1].count--;
                            balanceForArray = +this.$store.state.balance[this.orderDay];
                            balanceForArray += (+argTableDataDay[index - 1].price + +taraPrice + +forkPrice - rest);
                            this.$set(this.$store.state.balance, this.orderDay, Math.round((balanceForArray) * 100) / 100);

                            // this.$store.state.personalBalance = +this.$store.state.initialPersonalBalance - usedPersonalBalanceAtOtherDays;
                            this.$store.state.personalBalance += rest;

                            let total = this.$store.state.total[this.orderDay];
                            total -= (+argTableDataDay[index - 1].price + +taraPrice + +forkPrice);
                            this.$set(this.$store.state.total, this.orderDay, Math.abs(total)); // расчёт суммарно потраченных средств

                            let usedPersonalBalance = this.$store.state.usedPersonalBalance[this.orderDay];
                            usedPersonalBalance -= (+argTableDataDay[index - 1].price + +taraPrice + +forkPrice);
                            if (usedPersonalBalance < 0) {
                                usedPersonalBalance = 0;
                            }
                            this.$set(this.$store.state.usedPersonalBalance, this.orderDay, usedPersonalBalance); // расчёт потраченных личных средств

                            // this.dishesOrder[this.orderDay] = this.removeElementFromArray(this.dishesOrder, argTableDataDay[index - 1].db_id); // при отмене выбора блюда необходимо убрать его из массива с информацией о заказе
                            let dishesOrderArr = this.removeElementFromArray(this.dishesOrder[this.orderDay], argTableDataDay[index - 1].db_id); // при отмене выбора блюда необходимо убрать его из массива с информацией о заказе
                            this.$set(this.dishesOrder, this.orderDay, dishesOrderArr); // расчёт потраченных личных средств
                        }
                    }

                    // возрат средств для гарнира и мяса 333
                    else if (this.dishesTypes[typeIndex].name == 'гарнир' || this.dishesTypes[typeIndex].name == 'мясо') {
                        this.numberForFork[this.orderDay]--; // количество блюд, которые едят вилкой
                        this.$set(this.numberForFork, this.orderDay, this.numberForFork[this.orderDay]);

                        let forkIndex = this.getObjectFromArrayByProperty(this.requirements, 'name', 'Вилка');
                        let forkPrice = 0;

                        if (this.numberForFork[this.orderDay] == 0) { // последняя порция, кухонные принадлежности для него не нужны
                            forkPrice = this.requirements[forkIndex].price;
                        } else {
                            forkPrice = 0;
                        }

                        let taraIndex = this.getObjectFromArrayByProperty(this.requirements, 'name', 'Контейнер под мясное блюдо и гарнир');
                        let taraPrice = this.requirements[taraIndex].price;

                        let taraStartNumber = this.numberForGarnishOrMeatTara[this.orderDay]; // Количество тары под гарнир и/или мясо до удаления блюда (для расчёта цены)
                        this.$set(this.numberForGarnishOrMeatTara, this.orderDay, 0);

                        let garnishTaraStartNumber = this.numberForGarnishTara[this.orderDay]; // Количество тары под гарнир до удаления блюда (для расчёта цены)
                        this.$set(this.numberForGarnishTara, this.orderDay, 0);

                        let meatTaraStartNumber = this.numberForMeatTara[this.orderDay]; // Количество тары под мясоное до удаления блюда (для расчёта цены)
                        this.$set(this.numberForMeatTara, this.orderDay, 0);

                        let taraEndNumber = 0; // Количество тары под гарнир и/или мясо после удаления блюда (для расчёта цены)

                        // РАСЧЁТ КОЛИЧЕСТВА ТАРЫ
                        // Считаем сколько надо посуды для каждого уникального блюда (гарниры)
                        this.garnishIds[this.orderDay] = this.removeElementFromArray(this.garnishIds[this.orderDay], argTableDataDay[index - 1].db_id); // Удаляем id блюда от которого отказались
                        let unique = this.getUniqueArray(this.garnishIds[this.orderDay]);

                        let garnishNum = [];
                        for (let i = 0; i < unique.length; i++) {
                            garnishNum[i] = 0;

                            for (let j = 0; j < this.garnishIds[this.orderDay].length; j++) {
                                if (+unique[i] == +this.garnishIds[this.orderDay][j]) {
                                    garnishNum[i]++;
                                }
                            }

                            if (garnishNum[i] % 2 == 0) { // число блюд чётное, их можно расфосовать по ДВА в тару
                                // считаем количество тары для данного гарнира
                                garnishNum[i] = garnishNum[i] / 2;
                            } else {
                                // считаем количество тары для данного гарнира
                                garnishNum[i] = Math.ceil(garnishNum[i] / 2);
                            }
                        }

                        let numTara = 0;
                        for (let j = 0; j < garnishNum.length; j++) {
                            numTara += garnishNum[j];
                        }

                        this.$set(this.numberForGarnishTara, this.orderDay, numTara);


                        // Считаем сколько надо посуды для каждого уникального блюда (мясное)
                        this.meatIds[this.orderDay] = this.removeElementFromArray(this.meatIds[this.orderDay], argTableDataDay[index - 1].db_id); // Удаляем id блюда от которого отказались
                        unique = this.getUniqueArray(this.meatIds[this.orderDay]);

                        let meatNum = [];
                        for (let i = 0; i < unique.length; i++) {
                            meatNum[i] = 0;

                            for (let j = 0; j < this.meatIds[this.orderDay].length; j++) {
                                if (+unique[i] == +this.meatIds[this.orderDay][j]) {
                                    meatNum[i]++;
                                }
                            }

                            if (meatNum[i] % 2 == 0) { // число блюд чётное, их можно расфосовать по ДВА в тару
                                // считаем количество тары для данного гарнира
                                meatNum[i] = meatNum[i] / 2;
                            } else {
                                // считаем количество тары для данного гарнира
                                meatNum[i] = Math.ceil(meatNum[i] / 2);
                            }
                        }

                        numTara = 0;
                        for (let j = 0; j < meatNum.length; j++) {
                            numTara += meatNum[j];
                        }

                        this.$set(this.numberForMeatTara, this.orderDay, numTara);
                        // }


                        // Совмещаем гарниры и мясное в общей таре
                        if (this.numberForGarnishTara[this.orderDay] >= this.numberForMeatTara[this.orderDay]) { // Если гарниров больше, чем мяса (или столько же) - ложим всё к гарнирам
                            this.$set(this.numberForGarnishOrMeatTara, this.orderDay, this.numberForGarnishTara[this.orderDay]);
                        } else if (this.numberForGarnishTara[this.orderDay] < this.numberForMeatTara[this.orderDay]) {
                            this.$set(this.numberForGarnishOrMeatTara, this.orderDay, this.numberForMeatTara[this.orderDay]);
                        }

                        taraEndNumber = this.numberForGarnishOrMeatTara[this.orderDay];
                        taraPrice = taraPrice * (taraStartNumber - taraEndNumber);

                        // taraPrice = 0;

                        if ((this.$store.state.total[this.orderDay] - this.$store.state.initialBalance) > (+argTableDataDay[index - 1].price + +taraPrice + +forkPrice)) {
                            argTableDataDay[index - 1].count--;
                            this.$store.state.personalBalance += (+argTableDataDay[index - 1].price + +taraPrice + +forkPrice);

                            let total = this.$store.state.total[this.orderDay];
                            total -= (+argTableDataDay[index - 1].price + +taraPrice + +forkPrice);
                            this.$set(this.$store.state.total, this.orderDay, Math.abs(total)); // расчёт суммарно потраченных средств

                            let usedPersonalBalance = this.$store.state.usedPersonalBalance[this.orderDay];
                            usedPersonalBalance -= (+argTableDataDay[index - 1].price + +taraPrice + +forkPrice);

                            if (usedPersonalBalance < 0) {
                                usedPersonalBalance = 0;
                            }
                            this.$set(this.$store.state.usedPersonalBalance, this.orderDay, usedPersonalBalance); // расчёт потраченных личных средств

                            let dishesOrderArr = this.removeElementFromArray(this.dishesOrder[this.orderDay], argTableDataDay[index - 1].db_id); // при отмене выбора блюда необходимо убрать его из массива с информацией о заказе
                            this.$set(this.dishesOrder, this.orderDay, dishesOrderArr); // расчёт потраченных личных средств
                        } else {
                            let rest = 0; // расчёт остатка при смене условия
                            if (+this.$store.state.total[this.orderDay] > +this.$store.state.initialBalance) {
                                rest = +this.$store.state.total[this.orderDay] - +this.$store.state.initialBalance;
                            } else {
                                rest = 0;
                            }

                            argTableDataDay[index - 1].count--;
                            balanceForArray = +this.$store.state.balance[this.orderDay];
                            balanceForArray += (+argTableDataDay[index - 1].price + +taraPrice + +forkPrice - rest);
                            this.$set(this.$store.state.balance, this.orderDay, Math.round((balanceForArray) * 100) / 100);
                            // this.$store.state.personalBalance = +this.$store.state.initialPersonalBalance - usedPersonalBalanceAtOtherDays;
                            this.$store.state.personalBalance += rest;

                            let total = this.$store.state.total[this.orderDay];
                            total -= (+argTableDataDay[index - 1].price + +taraPrice + +forkPrice);
                            this.$set(this.$store.state.total, this.orderDay, Math.abs(total)); // расчёт суммарно потраченных средств

                            let usedPersonalBalance = this.$store.state.usedPersonalBalance[this.orderDay];
                            usedPersonalBalance -= (+argTableDataDay[index - 1].price + +taraPrice + +forkPrice);

                            if (usedPersonalBalance < 0) {
                                usedPersonalBalance = 0;
                            }
                            this.$set(this.$store.state.usedPersonalBalance, this.orderDay, usedPersonalBalance); // расчёт потраченных личных средств

                            let dishesOrderArr = this.removeElementFromArray(this.dishesOrder[this.orderDay], argTableDataDay[index - 1].db_id); // при отмене выбора блюда необходимо убрать его из массива с информацией о заказе
                            this.$set(this.dishesOrder, this.orderDay, dishesOrderArr); // расчёт потраченных личных средств
                        }
                    }

                    // возрат средств для блюд без тары, т.е. выпечка
                    else if (this.dishesTypes[typeIndex].name == 'выпечка') {
                        // if (+this.$store.state.personalBalance < +this.$store.state.initialPersonalBalance) {
                        if ((this.$store.state.total[this.orderDay] - this.$store.state.initialBalance) > (+argTableDataDay[index - 1].price)) {
                            argTableDataDay[index - 1].count--;
                            this.$store.state.personalBalance += +argTableDataDay[index - 1].price;

                            let total = this.$store.state.total[this.orderDay];
                            total -= (+argTableDataDay[index - 1].price);
                            this.$set(this.$store.state.total, this.orderDay, Math.abs(total)); // расчёт суммарно потраченных средств

                            let usedPersonalBalance = this.$store.state.usedPersonalBalance[this.orderDay];
                            usedPersonalBalance -= (+argTableDataDay[index - 1].price);

                            if (usedPersonalBalance < 0) {
                                usedPersonalBalance = 0;
                            }

                            this.$set(this.$store.state.usedPersonalBalance, this.orderDay, usedPersonalBalance); // расчёт потраченных личных средств

                            let dishesOrderArr = this.removeElementFromArray(this.dishesOrder[this.orderDay], argTableDataDay[index - 1].db_id); // при отмене выбора блюда необходимо убрать его из массива с информацией о заказе
                            this.$set(this.dishesOrder, this.orderDay, dishesOrderArr); // расчёт потраченных личных средств
                        } else {
                            let rest = 0; // расчёт остатка при смене условия
                            if (+this.$store.state.total[this.orderDay] > +this.$store.state.initialBalance) {
                                rest = +this.$store.state.total[this.orderDay] - +this.$store.state.initialBalance;
                            } else {
                                rest = 0;
                            }

                            argTableDataDay[index - 1].count--;
                            balanceForArray = +this.$store.state.balance[this.orderDay];
                            balanceForArray += (+argTableDataDay[index - 1].price - rest);
                            this.$set(this.$store.state.balance, this.orderDay, Math.round((balanceForArray) * 100) / 100);
                            // this.$store.state.personalBalance = +this.$store.state.initialPersonalBalance - usedPersonalBalanceAtOtherDays;
                            this.$store.state.personalBalance += rest;

                            let total = this.$store.state.total[this.orderDay];
                            total -= (+argTableDataDay[index - 1].price);
                            this.$set(this.$store.state.total, this.orderDay, Math.abs(total)); // расчёт суммарно потраченных средств

                            let usedPersonalBalance = this.$store.state.usedPersonalBalance[this.orderDay];
                            usedPersonalBalance -= (+argTableDataDay[index - 1].price);
                            if (usedPersonalBalance < 0) {
                                usedPersonalBalance = 0;
                            }
                            this.$set(this.$store.state.usedPersonalBalance, this.orderDay, usedPersonalBalance); // расчёт потраченных личных средств

                            let dishesOrderArr = this.removeElementFromArray(this.dishesOrder[this.orderDay], argTableDataDay[index - 1].db_id); // при отмене выбора блюда необходимо убрать его из массива с информацией о заказе
                            this.$set(this.dishesOrder, this.orderDay, dishesOrderArr); // расчёт потраченных личных средств
                        }
                    }
                }
            },

            // метод для формирования заказа (черновой варинат)
            createOrder: function () {
                // console.log('_____888');
                if (this.dishesOrder[this.orderDay].length > 0) {

                    // Заполняю массив с посудой данными для заказа
                    this.requirementsOrder[this.orderDay].length = 0; // Чищу массив от старых данных

                    // На каждое первое блюдо нужна ложка и тара
                    let spoonIdIndex = this.getObjectFromArrayByProperty(this.$store.state.requirements, 'name', 'Ложка');
                    let firstDishIdIndex = this.getObjectFromArrayByProperty(this.$store.state.requirements, 'name', 'Банка под первое блюдо');

                    if (this.numberForSpoon[this.orderDay] > 0) {

                        for (let i = 0; i < this.numberForSpoon[this.orderDay]; i++) {
                            this.requirementsOrder[this.orderDay].push(this.$store.state.requirements[spoonIdIndex].id);
                            this.requirementsOrder[this.orderDay].push(this.$store.state.requirements[firstDishIdIndex].id);
                        }
                    }

                    // Сохраняем данные о вилке
                    let forkIdIndex = this.getObjectFromArrayByProperty(this.$store.state.requirements, 'name', 'Вилка');

                    if (this.numberForFork[this.orderDay] > 0) {
                        this.requirementsOrder[this.orderDay].push(this.$store.state.requirements[forkIdIndex].id);
                    }

                    // Сохраняем данные о таре для салата
                    let saladIdIndex = this.getObjectFromArrayByProperty(this.$store.state.requirements, 'name', 'Контейнер для салата');

                    console.log('numberForSaladTara ' + this.numberForSaladTara[this.orderDay])
                    if (this.numberForSaladTara[this.orderDay] > 0) {
                        for (let i = 0; i < this.numberForSaladTara[this.orderDay]; i++) {
                            this.requirementsOrder[this.orderDay].push(this.$store.state.requirements[saladIdIndex].id);
                        }
                    }

                    // Сохраняем данные о таре для гарнира/мясного
                    let garnishMeatIdIndex = this.getObjectFromArrayByProperty(this.$store.state.requirements, 'name', 'Контейнер под мясное блюдо и гарнир');

                    if (this.numberForGarnishOrMeatTara[this.orderDay] > 0) {
                        for (let i = 0; i < this.numberForGarnishOrMeatTara[this.orderDay]; i++) {
                            this.requirementsOrder[this.orderDay].push(this.$store.state.requirements[garnishMeatIdIndex].id);
                        }
                    }

                    let initialPersonalBalanceAfterOrder = +this.$store.state.initialPersonalBalance - (this.$store.state.total[this.orderDay] - this.$store.state.initialBalance);

                    // if (!this.showAllDishes[this.orderDay]) { // 555
                        this.$axios.post('/orders', {
                            user_id: this.$store.state.user.id,
                            dishes_id: this.dishesOrder[this.orderDay],
                            requirements_id: this.requirementsOrder[this.orderDay],
                            date: this.$store.state.orderWeekDates[this.$store.state.orderDay + 1]['год'] + '-' + this.$store.state.orderWeekDates[this.$store.state.orderDay + 1]['месяц'] + '-' + this.$store.state.orderWeekDates[this.$store.state.orderDay + 1]['число'],
                            personal_balance_after_order: initialPersonalBalanceAfterOrder.toFixed(2),
                        }).then(response => {
                            console.log(response.data.status + ', ' + response.data.exist_order_id);

                            if (response.data.status == 'success') {
                                this.$refs.showNotify.showNotify('Ваш заказ принят!');
                                // this.$set(this.showAllDishes, this.orderDay, true);
                                this.$set(this.showAllDishes, this.orderDay, false);
                                this.ordersAtSession[this.orderDay] = true;

                                this.$axios.get('/get-user-info')
                                    .then((response) => {
                                        this.$store.state.user = response.data;

                                        if (this.$store.state.personalBalance == null) {
                                            this.$store.state.initialPersonalBalance = 0;
                                            this.$store.state.personalBalance = 0;
                                        } else {
                                            this.$store.state.initialPersonalBalance = response.data.personalBalance;
                                            // this.$store.state.personalBalance = response.data.personalBalance;
                                            // this.$store.state.personalBalance = +response.data.personalBalance.toFixed(2) - usedPersonalBalanceAtOtherDays.toFixed(2);
                                        }

                                    }).catch((err) => {
                                    console.log('Ошибка 4444' + err)
                                })
                            } else { // 44

                                let update_id = response.data.exist_order_id;

                                // перед удалением считаем сумму по заказу
                                this.$axios.get('/get-order-sum/' + response.data.exist_order_id + '/')
                                    .then((response) => {
                                        // console.log('sum ' + response.data.sum);
                                        // let response.data.sum

                                        // Сколько личного баланса использовано в удаляемом заказе
                                        let difSum = +(Math.round((response.data.sum) * 100) / 100) - +(Math.round((this.$store.state.initialBalance) * 100) / 100);

                                        if(difSum < 0) {
                                            difSum = 0;
                                        }

                                        // удаляем данные о старом заказе
                                        this.$axios.delete('/orders/' + update_id + '/', {}).then(response => {
                                            // сохраняем данные о новом заказе
                                            this.$axios.post('/orders', {
                                                user_id: this.$store.state.user.id,
                                                dishes_id: this.dishesOrder[this.orderDay],
                                                requirements_id: this.requirementsOrder[this.orderDay],
                                                date: this.$store.state.orderWeekDates[this.$store.state.orderDay + 1]['год'] + '-' + this.$store.state.orderWeekDates[this.$store.state.orderDay + 1]['месяц'] + '-' + this.$store.state.orderWeekDates[this.$store.state.orderDay + 1]['число'],
                                                personal_balance_after_order: initialPersonalBalanceAfterOrder + difSum,
                                            }).then(response => {
                                                if (response.data.status == 'success') {
                                                    this.$refs.showNotify.showNotify('Вы обновили заказ!');
                                                    // this.$set(this.showAllDishes, this.orderDay, true);
                                                    this.$set(this.showAllDishes, this.orderDay, false);
                                                    this.ordersAtSession[this.orderDay] = true;

                                                    this.$axios.get('/get-user-info')
                                                        .then((response) => {
                                                            this.$store.state.user = response.data;

                                                            if (this.$store.state.personalBalance == null) {
                                                                this.$store.state.initialPersonalBalance = 0;
                                                                this.$store.state.personalBalance = 0;
                                                            } else {
                                                                this.$store.state.initialPersonalBalance = +response.data.personalBalance;
                                                                // this.$store.state.personalBalance = +response.data.personalBalance;
                                                                // this.$store.state.personalBalance = +response.data.personalBalance.toFixed(2) - usedPersonalBalanceAtOtherDays.toFixed(2);
                                                            }

                                                        }).catch((err) => {
                                                        console.log('Ошибка 4444' + err)
                                                    })
                                                }
                                            }).catch((err) => {
                                                alert('Ошибка');
                                                console.log(err)
                                            });

                                        }).catch((err) => {
                                            console.log('Ошибка 111_ ' + err)
                                        });


                                    }).catch((err) => {
                                    console.log('Ошибка 55555 ' + err)
                                });

                            }
                        }).catch((err) => {
                            console.log('Ошибка 12345 ' + err)
                        });
                    /*}*/

                    // this.showAllDishes[this.orderDay] = false;
                    this.$set(this.showAllDishes, this.orderDay, false);

                } else {
                    this.$refs.showNotify.showNotify('Невозможно добавить заказ! Пожалуйста, выберите блюда!');
                }
            }
            ,

            // метод для редактирования заказа (черновой вариант)
            editOrder: function () {
                // console.log('_____999');
                // this.showAllDishes[this.orderDay] = true;
                this.$set(this.showAllDishes, this.orderDay, true);
            }
        }
    }
</script>

