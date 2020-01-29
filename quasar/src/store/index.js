import Vue from 'vue'
import Vuex from 'vuex'

import axios from 'axios'
// import VueAxios from 'vue-axios'

import example from './module-example'
// import {Store} from '../store'

Vue.use(Vuex);
// Vue.use(VueAxios, axios)

/*
 * If not building with SSR mode, you can
 * directly export the Store instantiation
 */

export default function (/* { ssrContext } */) {
    const Store = new Vuex.Store({
        state: {
            user: [],
            /*initialBalance: 70,
            balance: [70, 70, 70, 70, 70],*/
            initialBalance: 0,
            balance: [0, 0, 0, 0, 0],

            initialPersonalBalance: 0,
            personalBalance: 0,
            usedPersonalBalance: [0, 0, 0, 0, 0], // Использованно личных средств
            total: [0, 0, 0, 0, 0], // Всего денег потрачено

            dishes: [],
            daysForDishes: {'понедельник':[], 'вторник':[], 'среда':[], 'четверг':[], 'пятница':[]},
            // requirements: {'первое':[], 'гарнир и/или мясо':[], 'салат':[], 'ложка':[], 'вилка':[]}, // посуда и кухонные принадлежности
            dishesTypes: [], // типы блюд (для расчёта цены)
            dishesToRequirements: [], // связь блюд с необходимой тарой и кухонными принадлежностями
            requirements: [], // посуда и кухонные принадлежности
            orderDay: '', // нумерация дней ведётся с нуля для совместимости в функцией getDay в DishOrder
            today: '',
            orderWeekDates: [], // массив с информацией о датах на все дни недели на которые можно сделать заказ
        },
        modules: {
            example
        },
        getters: {
            getUser: (state) => {
                return state.user;
                console.log('user ' + state.user)
            },
        },
        actions: {
            getBalanceFromDB({state, dispatch, commit}) {
                axios.get('/get-user-info')
                    .then((response) => {
                        // this.$store.state.user = response.data;
                        state.initialPersonalBalance = +response.data.personalBalance;
                        state.personalBalance = +response.data.personalBalance;

                        for (let i = 0; i < state.balance.length; i++) {
                            state.balance[i] = +response.data.balance;
                        }

                        if(state.personalBalance == null) {
                            // state.initialPersonalBalance = 0;
                            state.personalBalance = 0;
                        } else {
                            // state.initialPersonalBalance = +response.data.personalBalance;
                            state.personalBalance = +response.data.personalBalance;
                        }

                    }).catch((err) => {
                    console.log('Ошибка 222 ' + err)
                })
            },

            getTodayDayOfWeek({state, dispatch, commit}) {
                axios.get('/get-today-day-of-week')
                    .then((response) => {
                        state.today = response.data;
                        // state.orderDay = state.today;
                        console.log('today ' +state.today);
                    }).catch((err) => {
                    console.log('Ошибка' + err)
                })
            },

            getOrderWeekDates({state, dispatch, commit}) {
                axios.get('/get-dates')
                    .then((response) => {
                        state.orderWeekDates = response.data;
                    }).catch((err) => {
                    console.log('Ошибка' + err)
                })
            },

            getDishes({state, dispatch, commit}, callback) {
                axios.get('/get-dishes')
                    .then((response) => {
                        state.dishes = response.data;
                        callback(state.dishes);
                    }).catch((err) => {
                    console.log('Ошибка ' + err)
                })
            },
            getDaysForDishes({state, dispatch, commit}) {
                axios.get('/get-days-for-dishes')
                    .then((response) => {
                        for (let i = 0; i < response.data.length; i++) {
                            if (response.data[i].name == 'понедельник') {
                                state.daysForDishes['понедельник'].push(response.data[i].dish_id);
                            }
                            if (response.data[i].name == 'вторник') {
                                state.daysForDishes['вторник'].push(response.data[i].dish_id);
                            }
                            if (response.data[i].name == 'среда') {
                                state.daysForDishes['среда'].push(response.data[i].dish_id);
                            }
                            if (response.data[i].name == 'четверг') {
                                state.daysForDishes['четверг'].push(response.data[i].dish_id);
                            }
                            if (response.data[i].name == 'пятница') {
                                state.daysForDishes['пятница'].push(response.data[i].dish_id);
                            }
                        }
                    }).catch((err) => {
                    console.log('Ошибка ' + err)
                })
            },

            getDishesTypes({state, dispatch, commit}) {
                axios.get('/get-dishes-types')
                    .then((response) => {
                        state.dishesTypes = response.data;

                        /*console.log('T ' + state.dishesTypes.length)
                        console.log('T ' + state.dishesTypes[0].name)*/
                    }).catch((err) => {
                    console.log('Ошибка ' + err)
                })
            },

            getDishesToRequirements({state, dispatch, commit}) {
                axios.get('/get-dishes-to-requirements')
                    .then((response) => {
                        state.dishesToRequirements = response.data;

                        /*console.log(state.dishesToRequirements.length)
                        console.log(state.dishesToRequirements[0].requirement_id)*/
                    }).catch((err) => {
                    console.log('Ошибка ' + err)
                })
            },

            getRequirements({state, dispatch, commit}) {
                axios.get('/get-requirements')
                    .then((response) => {
                        state.requirements = response.data;

                        /*console.log(state.requirements.length)
                        console.log(state.requirements[0].name)*/

                    }).catch((err) => {
                    console.log('Ошибка ' + err)
                })
            },
            axiosUser () {

                return new Promise((resolve, reject) => {

                    axios.get('get-user-info').then((response) => {

                        resolve(response.data);
                    }).catch(error => {
                        console.error(error);
                    });
                });

            }
        },
        mutations: {
            setUser: (state, data) => {
                state.user = data;
            }
        }
    });

    return Store
}

