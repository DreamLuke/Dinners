<template>
    <q-layout>
        <q-page padding>

            <h5 class="title">Список пользователей</h5>


            <q-table id="userControl"
                     :data="search"
                     :columns="columns"
                     row-key="name"
                     class="shadow-0"
                     :rows-per-page-options="[0]"
                     :pagination.sync="pagination"
                     hide-bottom
                     :separator="separator"
            >

                <!--ПОИСК-->
                <q-tr slot="top-row" slot-scope="props">
                    <q-td>
                        <q-search no-icon
                                  hide-underline
                                  color="secondary"
                                  type="text"
                                  placeholder="Поиск..."
                                  style="font-size: 13px"
                                  v-model="filter.id"
                        />
                    </q-td>
                    <q-td>
                        <q-search no-icon
                                  hide-underline
                                  color="secondary"
                                  type="text"
                                  placeholder="Поиск..."
                                  style="font-size: 13px"
                                  v-model="filter.fio"
                        />
                    </q-td>
                    <q-td>
                        <q-search no-icon
                                  hide-underline
                                  color="secondary"
                                  type="text"
                                  placeholder="Поиск..."
                                  style="font-size: 13px"
                                  v-model="filter.email"
                        />
                    </q-td>
                    <q-td>
                        <q-search no-icon
                                  hide-underline
                                  color="secondary"
                                  type="text"
                                  placeholder="Поиск..."
                                  style="font-size: 13px"
                                  v-model="filter.telegram"
                        />
                    </q-td>
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
                    <q-td key="id" :props="props">
                        <span>{{props.row.id}}</span>
                    </q-td>

                    <q-td key="fio" :props="props">
                        <span>{{props.row.name}}</span>
                    </q-td>

                    <q-td key="email" :props="props">
                        <span>{{props.row.email}}</span>
                    </q-td>

                    <q-td key="telegram" :props="props">
                        <span>{{props.row.telegram}}</span>
                    </q-td>

                    <q-td key="access" :props="props">
                        <input type="checkbox"
                               :checked="isAccess(props.row.id, 0)"
                               @click="makeAccess(props.row.id)"
                               :disabled="disabledAcess(props.row)"
                        >
                    </q-td>

                    <q-td key="admin" :props="props">
                        <input type="checkbox"
                               :checked="isAccess(props.row.id, 1)"
                               @click="adminAccess(props.row.id)"
                               :disabled="disabledAdmin(props.row)"
                        >
                    </q-td>

                    <q-td key="personalBalance" :props="props">
                        <span>{{props.row.personalBalance ? (props.row.personalBalance + ' грн.'):''}}</span>
                    </q-td>

                    <q-td key="donate" :props="props">
                        <img src="../../statics/icons/plus.png" @click="showDonut(props.row)">
                    </q-td>

                    <q-td key="userEdit" :props="props">
                        <img src="../../statics/icons/edit.svg"
                             @click="showEdit({val: 1, title: 'Редактирование сотрудника'}, props.row)"
                        >
                    </q-td>

                    <q-td key="userDelete" :props="props">
                        <img src="../../statics/icons/remove.svg" @click="showConfirm(props.row.id)">
                    </q-td>
                </q-tr>
            </q-table>

            <q-btn class="shadow-0"
                   label="Добавить сотрудника"
                   size="md"
                   text-color="white"
                   rounded
                   flat
                   @click="showEdit({val: 0, title: 'Добавление сотрудника'})"
            />

            <donate-popup ref="donutOpen" @makeDonut="makeDonut"></donate-popup>
            <user-popup ref="showUser"></user-popup>
            <delete-confirm ref="showNotify" @confirmDelete="deleteUser"></delete-confirm>
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
    #userControl tr td img {
        cursor: pointer;
        width: 18px;
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
    button {
        margin-top: 25px;
        background-color: #3E6DB9;
        padding: 11px 23px 12px 23px;
        float: right;
        text-transform: capitalize;
        font-size: 12px !important;
    }
    button:active {
        box-shadow: none;
    }
</style>
<style>
    #userControl {
        width: auto;
        border: 1px solid #d6d6d8;
    }
    #userControl .q-table-middle thead tr th {
        position: sticky;
        position: -webkit-sticky;
        top: -1px;
        z-index: 1;
        background-color: #ddd;
    }
    #userControl .q-table-middle.scroll {
        overflow: visible;
    }
    #userControl .q-table-middle {
        width: 100%;
        overflow: unset;
    }
    #userControl .q-table {
        border: 1px solid #d6d6d8;
        width: 100%;
    }
    #userControl .q-table tbody tr td span {
        color: #000;
    }
    #userControl thead tr {
        height: 40px;
    }
    #userControl thead th,
    #userControl tbody td {
        border: 1px solid #d6d6d8;
        height: 40px;
    }
    #userControl thead tr th,
    #userControl tbody tr td {
        padding: 0 10px;
    }
    /*дни недели, редактирование, удаление*/
    #userControl tbody tr td:nth-child(1),
    #userControl tbody tr td:nth-last-child(1),
    #userControl tbody tr td:nth-last-child(2),
    #userControl tbody tr td:nth-last-child(3),
    #userControl tbody tr td:nth-last-child(5),
    #userControl tbody tr td:nth-last-child(6) {
        text-align: center;
        width: 45px;
        box-sizing: border-box;
        padding-top: 4px;
    }
    #userControl tbody tr td:nth-last-child(5),
    #userControl tbody tr td:nth-last-child(6) {
        padding: 0;
        margin: 0;
    }
</style>


<script>
    import store from '../../store/admin'
    import { mapGetters } from 'vuex'
    import DonatePopup from '../../components/admin/donate-popup'
    import UserPopup from '../../components/admin/user-popup'
    import DeleteConfirm from '../../components/admin/delete-confirm'
    import axios from 'axios'
    import UserStore from '../../store'

    export default {
        store,UserStore,
        components: {DonatePopup, UserPopup, DeleteConfirm},
        data() {
            return {
                separator: 'cell',
                pagination: {
                    page: 1,
                    rowsPerPage: 0
                },
                filter: {
                    id: '',
                    fio: '',
                    email: '',
                    telegram: ''
                },
                user: '',
                columns: [
                    {
                        name: 'id',
                        label: 'id',
                        field: 'id',
                        sortable: true,
                        align: 'center'
                    },
                    {
                        name: 'fio',
                        label: 'ФИО',
                        field: 'fio',
                        sortable: true,
                        align: 'center'
                    },
                    {
                        name: 'email',
                        label: 'Почта',
                        field: 'emain',
                        sortable: true,
                        align: 'center'
                    },
                    {
                        name: 'telegram',
                        label: 'Телеграм',
                        field: 'telegram',
                        sortable: false,
                        align: 'center'
                    },
                    {
                        name: 'access',
                        label: 'Доступ',
                        field: 'access',
                        sortable: false,
                        align: 'center'
                    },
                    {
                        name: 'admin',
                        label: 'Админ',
                        field: 'admin',
                        sortable: false,
                        align: 'center'
                    },
                    {
                        name: 'personalBalance',
                        label: 'Личный баланс',
                        field: 'personalBalance',
                        sortable: false,
                        align: 'center'
                    },
                    {
                        name: 'donate',
                        label: '',
                        field: 'donate',
                        sortable: false,
                        align: 'center'
                    },
                    {
                        name: 'userEdit',
                        label: '',
                        field: 'userEdit',
                        sortable: false,
                        align: 'center'
                    },
                    {
                        name: 'userDelete',
                        label: '',
                        field: 'userDelete',
                        sortable: false,
                        align: 'center'
                    },
                ]
            }
        },
        mounted() {
            store.dispatch('axiosUsers');
            UserStore().dispatch('axiosUser')
                .then(response => {

                    this.user = response;
                })
        },
        methods: {
            disabledAcess(user_opt) {
                return user_opt.role === 'admin' && this.user.accessLevel < 3;
            },
            disabledAdmin() {
                return this.user.accessLevel < 3;
            },
            isAccess(user_id, accessLevel) {
                let roles = ['user', 'admin'];

                for (let key in this.users) {

                    if (Number(user_id) === Number(this.users[key].id)) {

                        if (Number(this.users[key].accessLevel) > Number(accessLevel) &&
                            roles.includes(this.users[key].role)) {

                            return true
                        }
                    }
                }
            },
            showDonut(props) {

                this.$refs.donutOpen.donutOpen(props);
            },
            makeDonut(props, donutValue) {

                //запрос на обновление
                axios.patch('/control/donate', {user: props.id, donut: donutValue})
                    .then(response => {

                        store.dispatch('axiosUsers');
                    })
                    .catch(error => {
                        console.error(error);
                    })
            },
            makeAccess(id) {

                axios.patch('/control/user', {id: id, editor_id: this.user.id})
                    .then(response => {

                        store.dispatch('axiosUsers');
                    })
                    .catch(error => {
                        console.error(error);
                    });
            },
            adminAccess(id) {

                axios.patch('/control/admin',{id: id, editor_id: this.user.id})
                    .then(response => {
                        store.dispatch('axiosUsers');
                    })
                    .catch(error => {
                        console.error(error);
                    });

            },
            showEdit(title, props) {

                //открывает модалку редактирования пользователя
                this.$refs.showUser.showUser(title, props);
            },
            showConfirm(id) {

                this.$refs.showNotify.showNotify('Подтвердить удаление?', id);
            },
            deleteUser(data) {

                axios.delete('/control/destroy', {params: {id: data}})
                    .then(response => {

                        store.dispatch('axiosUsers');
                    })
                    .catch(error => {
                        console.error(error);
                    });
            }
        },
        computed: {
            ...mapGetters({
                users: 'getUsers'
            }),
            search() {

                //смотрим, есть ли ввод поиска
                let id = this.filter.id ? Number(this.filter.id) : '';
                let fio = this.filter.fio ? this.filter.fio.toLowerCase() : '';
                let email = this.filter.email ? this.filter.email : '';
                let telegram = this.filter.telegram ? this.filter.telegram.toLowerCase() : '';

                let tempArr = this.users;


                if (id || fio || email || telegram) {

                    if (id) {

                        tempArr = tempArr.filter(row => {

                            return Number(row.id) === id ? row : '';
                        });
                    }

                    if (fio) {
                        tempArr = tempArr.filter(row => {

                            return row.name ? row.name.toLowerCase().match(fio) : '';
                        });
                    }

                    if (email) {
                        tempArr = tempArr.filter(row => {

                            return row.email ? row.email.match(email) : '';
                        });
                    }

                    if (telegram) {
                        tempArr = tempArr.filter(row => {

                            return row.telegram ? row.telegram.toLowerCase().match(telegram) : '';
                        });
                    }

                    //готовый массив нужно вернуть в конце
                    return tempArr;

                } else {

                    return tempArr;
                }

            }
        }
    }
</script>