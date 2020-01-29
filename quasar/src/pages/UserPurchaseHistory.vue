<template>
    <q-page padding>
        <div>
            <div style="overflow: hidden">
                <p class="date">Выберите дату:</p>
                <q-datetime @change="postDate" format="DD.MM.YYYY" class="datetime" v-model="dateDish"/>
            </div>
            <div ref="content">
                <h5 class="dateFor">Обед на {{ dateOrders }}</h5>
            </div>

            <div class="table">
                <div class="head">
                    <ul class="tr">
                        <li class="td name">
                            <span>Наименование</span>
                        </li>
                        <li class="td count">
                            <span>Количество</span>
                        </li>
                        <li class="td price">
                            <span>Цена (грн)</span>
                        </li>
                    </ul>
                </div>
                <div class="body">
                    <ul class="tr" v-for="item in ordersInfo" v-if="item.name">
                        <li class="td name">
                            <img :src="setImage(item)">
                            <div class="container">

                                <span>
                                    {{item.name}}
                                </span>

                                <span class="dishName" v-if="!show" v-on:click="show = !show">{{item.weight}}</span>

                                <span class="dishName" v-if="show" v-on:click="show = !show">
                                    {{item.composition ? item.composition : 'Нет описания'}}
                                </span>

                            </div>
                        </li>
                        <li class="td count">
                            <span>{{item.count}}</span>
                        </li>
                        <li class="td price">
                            <span>{{item.price}}</span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <!--<user-balance :balance=this.orderTotalSum></user-balance>-->
        <!--<user-balance :balance=12></user-balance>-->
        <user-balance :total=this.orderTotalSum :balance=this.balance :usedPersonalBalance=this.usedPersonalBalance></user-balance>
    </q-page>
</template>

<script>
    import UserBalance from "../components/user-balance";

    export default {
        name: 'PurchaseHistory',
        components: {UserBalance},
        data() {
            return {
                show: true,
                dateDish: new Date(),
                dateBake: new Date(),
                ordersInfo: [],
                perUserInfo: [],
                dateOrders: '',
                orderId: '',
                orderTotalSum: 0,
                balance: 0,
                usedPersonalBalance: 0,
            }
        },
        mounted() {
            this.getUserId();
            this.getOrderForDate();
            this.postDate();
            this.$store.dispatch('getDishesTypes');
        },
        methods: {
            setImage(data) {

                for (let key in this.dishesTypes) {

                    if (Number(this.dishesTypes[key].id) === Number(data.type_id)) {

                        if (this.dishesTypes[key].image_link) {
                            return require('../statics/food/' + this.dishesTypes[key].image_link);
                        } else {
                            return require('../statics/food/default.svg');
                        }
                    }
                }
            },
            postDate() {
                // this.$axios.post('/get-order-date', {
                this.$axios.post('/get-order-by-user', {
                    dateDish: this.dateDish
                }).then(response => {
                    if (response.data == 'выберите дату') {
                        this.data = response.data;
                        this.error = response.data;
                    } else {
                        this.data = response.data;
                        this.error = '';
                        this.ordersInfo = response.data.ordersInfo;
                        this.perUserInfo = response.data.perUserInfo;
                        this.dateOrders = response.data.dateOrders;
                        this.ordersInfoRequirements = response.data.ordersInfoRequirements;

                        this.getOrderForDate();
                    }
                }).catch((err) => {
                    // alert('Ошибка');
                    console.log(err)
                })
            },
            getUserId() {
                // getUserInfo
                this.$axios.get(('/get-user-info')).then((response) => {
                    console.log('user: ' + response.data['id']);
                }).catch((err) => {
                    console.log('Ошибка' + err)
                });
            },
            getOrderForDate() {
                this.$axios.post('/get-order-for-date', {
                // this.$axios.post('//get-order-for-date-by-user', {
                    date: this.dateDish.getFullYear() + '-' + ('0' + (this.dateDish.getMonth() + 1)).slice(-2) + '-' + ('0' + this.dateDish.getDate()).slice(-2)
                }).then(response => {
                    this.orderId = +response.data.order[0]['id'];

                    /*console.log('_data_: ' + this.orderId);
                    console.log('_data_: ' + this.dateDish);*/

                    this.$axios.get('/get-order-sum/' + this.orderId + '/')
                        .then((response) => {
                            this.orderTotalSum = +response.data.sum.toFixed(2);

                            if(+this.orderTotalSum >= this.$store.state.initialBalance) {
                                // console.log('1 sum ' + +this.orderTotalSum);
                                this.balance = 0;
                                this.usedPersonalBalance = +this.orderTotalSum - +this.$store.state.initialBalance;
                            } else {
                                // console.log('2 sum ' + +this.orderTotalSum);
                                this.balance = +this.$store.state.initialBalance - +this.orderTotalSum;
                                this.usedPersonalBalance = 0;
                            }
                        }).catch((err) => {
                        console.log('Ошибка' + err)
                    });

                }).catch((err) => {
                    // alert('Ошибка');
                    console.log(err)
                })
            },
        },
        computed: {
            dishesTypes() {
                return this.$store.state.dishesTypes;
            }
        }
    }
</script>

<style scoped>
    /*ТАБЛИЦА*/
    .table {
        float: left;
        min-width: 400px;
        width: 80%;
    }
    .table .head {
        color: #A6A6A6;
        border-bottom: 1px solid #E7E7E7;
        font-size: 13px;
        line-height: 18px;
        padding: 0 4% 5px 3%;
    }
    .table .head .tr {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .table .head .tr .name {
        display: flex;
        justify-content: flex-start;
        align-items: center;
    }
    .table .body .tr .name img {
        width: 46px;
        height: 44px;
    }
    .table .body .tr .name .container {
        margin: 5px 0 0 25px;
    }
    .table .body .tr .name .container span {
        display: block;
        font-size: 14px;
        margin: 0 0 3px 0;
    }
    .table .body .tr .name .container .dishName {
        display: block;
        font-size: 12px;
        color: #A6A6A6;
    }

    .table .head .tr .count,
    .table .head .tr .price {
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .table .head .name {
        width: 67%;
    }
    .table .head .count {
        width: 30%;
    }
    .table .head .price {
        width: 40%;
    }


    .table .head .tr .td,
    .table .body .tr .td {

    }
    .table .body {
        color: #043DA0;
        max-height: 550px;
        overflow-y: scroll;
        overflow-x: hidden;
    }
    .table .body .tr {
        display: flex;
        justify-content: space-between;
        align-items: center;
        height: 75px;
        border-bottom: 1px solid #E7E7E7;
        transition: 0.1s;
        padding: 0 25px;
    }
    .table .body .tr:hover {
        background-color: rgba(0,0,0,.03);
    }


    .table .body .tr .td {
        height: 100%;
        display: flex;
        align-items: center;
    }

    .table .body .tr .name {
        justify-content: flex-start;
    }
    .table .body .tr .name span:first-child {
        cursor: pointer;
    }

    .table .body .tr .count,
    .table .body .tr .price {
        justify-content: center;
    }
    .table .body .tr .count {
        color: #494949;
        font-size: 24px;
        line-height: 29px;
    }
    .table .body .tr .price {
        font-size: 24px;
        line-height: 29px;
    }

    .table .name {
        width: 67%;
    }
    .table .count {
        width: 30%;
    }
    .table .body .count {
        padding-right: 1%;
    }
    .table .price {
        width: 40%;
    }
    .table .body .price {
        padding-left: 1.5%;
    }

    /*ТАБЛИЦА*/

    tr,
    th,
    td {
        border: 0.25px solid #000000;
        font-size: 14px;
        color: #555555;
        font-style: normal;
        font-weight: 500;
    }

    .q-table thead tr,
    .q-table tbody td {
        height: 22px;
        text-align: center;
    }

    .q-table tbody .name {
        text-align: left;
    }

    .dateFor {
        width: 80%;
        text-align: center;
        font-style: normal;
        font-weight: bold;
        font-size: 16px;
        color: #0C4CBC;
    }

    .q-table th, .q-table td {
        padding: 0 5px;
    }

    .date {
        font-style: normal;
        font-weight: bold;
        font-size: 16px;
        color: #0C4CBC;
        float: left;
    }

    .datetime {
        float: left;
        margin-left: 73px;
        background: #FFFFFF;
        border: 1px solid #043DA0;
        border-radius: 5px;
        height: 20px;
        font-style: normal;
        font-weight: normal;
        font-size: 12px;
        color: #043DA0;
    }

    .btn_absent .q-btn-inner {
        font-style: normal;
        font-weight: 500;
        font-size: 11px;
        text-align: center;
        color: #FFFFFF;
    }
</style>

