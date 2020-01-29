import state from './state'
import * as getters from './getters'
import * as mutations from './mutations'
import * as actions from './actions'

import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'

Vue.use(Vuex);

export default new Vuex.Store({
    modules: {state, getters, actions, mutations},
    state: {
        dishes: [],
        dishesTypes: [],
        daysForDishes: [],
        users: [],
        reasons: [],
        absences: []
    },
    getters: {
        getDishes: state => {
            return state.dishes;
        },
        getDishesTypes: state => {
            return state.dishesTypes;
        },
        getDaysForDishes: state => {
            return state.daysForDishes;
        },
        getUsers: state => {
            return state.users;
        },
        getReasons: state => {
            return state.reasons;
        },
        getAbsences: state => {
            return state.absences;
        }
    },
    actions: {
        axiosDishes: function ({commit}) {

            axios.get('/get-dishes').then(response => {

                commit('setDishes', response.data);
            }).catch(error => {
                console.log(error);
            });
        },
        axiosDishesTypes: function ({commit}) {

            axios.get('/get-dishes-types').then(response => {

                commit('setDishesTypes', response.data);
            }).catch(error => {
                console.log(error);
            });
        },
        axiosDaysForDishes: function ({commit}) {

            axios.get('/get-days-for-dishes').then(response => {

                commit('setDaysForDishes', response.data);
            }).catch(error => {
                console.log(error);
            });
        },
        axiosUsers: function ({commit}) {

            axios.get('/control/users').then(response => {

                commit('setUsers', response.data);
            }).catch(error => {
                console.error(error);
            });
        },
        axiosReasons({commit}) {

            axios.get('/get-reasons').then(response => {

                    commit('setReasons', response.data);
                })
                .catch(error => {
                    console.error(error);
                })

        },
        axiosAbsences({commit}) {

            axios.get('/get-absences').then(response => {

                commit('setAbsences', response.data)
            })
                .catch(error => {
                    console.error(error);
                })
        }
    },
    mutations: {
        setDishes: (state, data) => {
            state.dishes = data;
        },
        setDishesTypes: (state, data) => {
            state.dishesTypes = data
        },
        setDaysForDishes: (state, data) => {

            let arr = [];
            for (let key in data) {

                if (!arr[data[key].day_number]) {
                    arr[data[key].day_number] =
                        {
                            name: data[key].name,
                            dishes: []
                        };
                }
                arr[data[key].day_number].dishes.push(Number(data[key].dish_id));
            }
            state.daysForDishes = arr;
        },
        setUsers: (state, data) => {
            state.users = data;
        },
        setReasons: (state, data) => {
            state.reasons = data;
        },
        setAbsences: (state, data) => {
            state.absences = data;
        }
    }
})
