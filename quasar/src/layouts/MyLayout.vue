<template>
    <q-layout view="lHh Lpr lFf">
        <q-layout-header class="shadow-0">
            <q-toolbar
                    color=""
                    :glossy="$q.theme === ''"
                    :inverted="$q.theme === 'ios'"
            >
                <q-btn v-if="Number(this.$store.getters.getUser.accessLevel) > 0"
                       flat
                       dense
                       round
                       @click="leftDrawerOpen = !leftDrawerOpen"
                       aria-label="Menu"
                >
                    <q-icon name="menu"/>
                </q-btn>

                <q-toolbar-title>
                    <div class="logo_dinner">
                        <img alt="Dinner Logo" src="../statics/icons/dinner.svg">
                    </div>
                    <p class="header">Заказ обедов</p>
                </q-toolbar-title>
            </q-toolbar>
            <br>
        </q-layout-header>
        <q-layout-drawer
                v-cloak
                v-if="Number(this.$store.getters.getUser.accessLevel) > 0"
                v-model="leftDrawerOpen"
                :content-class="$q.theme === 'mat' ? 'shadow-0' : null"
                :content-style="{'backgroundColor':'#7fa7e5'}"
        >
            <q-list no-border
                    link
                    inset-delimiter
            >
                <q-list-header>
                    <a href="/">
                        <img alt="IT2.0 Logo" src="../statics/icons/logo.svg">
                    </a>
                </q-list-header>

                <auth-user></auth-user>

                <!--user-->
                <template v-if="this.$store.getters.getUser.role === 'user'">
                    <q-item v-for="key in menu.user" :key="key.name" class="list">
                        <q-item-side/>
                        <img class="left_menu_icon" :src="key.icon">
                        <router-link :to="key.url" class="white-text">
                            <q-item-main :label="key.name"/>
                        </router-link>
                    </q-item>
                    <q-item>
                        <q-item-side/>
                        <img class="left_menu_icon" src="../statics/icons/logout.svg">


                        <a id="logout" href="#" v-on:click.prevent="logout()">Выйти</a>
                    </q-item>
                </template>

                <!--admin-->
                <template v-if="this.$store.getters.getUser.role === 'admin'">
                    <q-item v-for="key in menu.admin" :key="key.name" class="list">
                        <q-item-side/>
                        <img class="left_menu_icon" :src="key.icon">
                        <router-link :to="key.url" class="white-text">
                            <q-item-main :label="key.name"/>
                        </router-link>
                    </q-item>
                    <q-item>
                        <q-item-side/>
                        <img class="left_menu_icon" src="../statics/icons/logout.svg">

                        <a id="logout" href="#" v-on:click.prevent="logout()">Выйти</a>
                    </q-item>
                </template>


            </q-list>
        </q-layout-drawer>

        <q-page-container>
            <router-view/>
        </q-page-container>

    </q-layout>
</template>

<script>
    import {openURL} from 'quasar'
    import GoogleAuth from "../components/google-auth.vue"
    import AuthUser from "../components/auth-user.vue"
    import axios from 'axios'

    //МАСКА
    import jQueury from '../assets/js/jQuery'
    import jqmask from '../assets/js/jquery.mask'

    import AccessDenied from '../components/no-access'

    export default {
        name: 'MyLayout',
        components: {GoogleAuth, AuthUser, AccessDenied},
        data() {
            return {
                menu: {
                    user: [
                        {
                            name: 'Обед',
                            icon: require('../statics/icons/restaurant.svg'),
                            url: '/dish_order'
                        },
                        {
                            name: 'История заказов',
                            icon: require('../statics/icons/history.svg'),
                            url: '/usr_purchase_history'
                        },
                        {
                            name: 'Отсутствие',
                            icon: require('../statics/icons/avatar.svg'),
                            url: '/absent_page'
                        }
                    ],
                    admin: [
                        {
                            name: 'История заказов',
                            icon: require('../statics/icons/history.svg'),
                            url: '/adm_purchase_history'
                        },
                        {
                            name: 'Управление пользователями',
                            icon: require('../statics/icons/avatar.svg'),
                            url: '/user_control'
                        },
                        {
                            name: 'Меню',
                            icon: require('../statics/icons/restaurant.svg'),
                            url: '/menu'
                        },
                        {
                            name: 'Рейтинг блюд',
                            icon: require('../statics/icons/rate.svg'),
                            url: '/dishes_rates'
                        },
                        {
                            name: 'Журнал посещаемости',
                            icon: require('../statics/icons/book.svg'),
                            url: '/journal'
                        },
                        {
                            name: 'Производственный календарь',
                            icon: require('../statics/icons/organizer.png'),
                            url: '/product_calendar'
                        }
                    ]},
                leftDrawerOpen: this.$q.platform.is.desktop
            }
        },
        mounted() {
            this.$axios.get('/get-user-info')
                .then((response) => {
                    this.$store.state.initialBalance = +response.data.balance;

                    this.$store.state.initialPersonalBalance = +response.data.personalBalance;
                    this.$store.state.personalBalance = +response.data.personalBalance;

                    for (let i = 0; i < +this.$store.state.balance.length; i++) {
                        this.$store.state.balance[i] = +response.data.balance;
                    }
                }).catch((err) => {
                console.log('Ошибка 123 ' + err)
            });

            let context = this;

            this.$store.dispatch('getBalanceFromDB');

            this.$store.dispatch('axiosUser').then(response => {

                this.$store.commit('setUser', response);
            }).then(function () {

                context.setHighlight;
            });
        },
        computed: {
            /*balance () {
                return this.$store.state.balance
            },*/
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
            personalBalance () {
                return this.$store.state.personalBalance
            },
            setHighlight() {

                let list = document.querySelectorAll('.list');

                for (let i = 0; i < list.length; i++) {

                    if (list[i].childNodes[2].classList.contains('router-link-exact-active')) {
                        list[i].classList.add('backLight');
                    }

                    list[i].addEventListener('click', function () {

                        for (let i = 0; i < list.length; i++) {

                            list[i].classList.remove('backLight');
                        }

                        this.classList.add('backLight');
                    });
                }
            },
        },
        methods: {
            logout() {

                this.$axios.post('/auth/logout').then(response => {

                    location.reload();
                }).catch(error => {
                    console.error(error);
                });
            }
        }
    }
</script>


<style>
    .q-layout-header {
        box-sizing: border-box;
        height: 100px;
    }
    .logo_dinner {
        margin: 10px 0 0 0;
    }
    .header {
        width: 93.1%;
        margin: 5px 0 0 0;
    }

    .backLight { /*активная страница в меню, подсветка*/
        background-color: #136598; /*#568ecb #136598*/
    }
    .q-item:nth-child(2):hover {
        cursor: default;
        background-color: inherit;
    }
    #logout {
        color: #fff;
        padding: 15px 0 0 15px;
        display: block;
        height: 100%;
        width: 100%;
    }
    .q-item {
        padding: 0 0 0 7%;
        height: 48px;
        font-style: normal;
        font-weight: 500;
        font-size: 14px;
        line-height: 17px;
        display: flex;
        align-items: center;
        transition: 0.1s;
    }

    .q-list-highlight > .q-item:hover,
    .q-item-highlight:hover,
    .q-list-link > .q-item:hover:not(.user),
    .q-item-link:hover {
        background: #7e9cca;
    }


    .q-item-main {
        margin: 0 0 0 5%;
    }
    .list a {
        width: 100%;
        height: 100%;
        box-sizing: border-box;
        padding-top: 15px;
    }
    .list img {
        width: 22px;
        height: 22px;
        padding: 0;
    }
    .user {
        border: none;
        padding: 18px 5% 15px 5%;
        height: auto;
        display: grid;
        grid-template-columns: 1fr 1fr 10fr;
    }
    .user .userContainer {
        text-align: center;
    }
    .user .userContainer .q-item-main {
        width: auto;
        margin: 0;
        font-style: normal;
        font-weight: 600;
        font-size: 14px;
        line-height: 17px;
        text-align: center;
    }
    .user > .q-item-main:last-child {
        grid-column: 1/4;
        text-align: center;
        margin: 20px 0 0 0;
    }
    .router-link-exact-active {
        font-style: normal;
        font-weight: bold;
        font-size: 14px;
        line-height: 17px;
    }
</style>
