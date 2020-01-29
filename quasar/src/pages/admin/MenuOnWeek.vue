<template>
    <q-layout>
        <q-page padding id="showMenu">
            <h5 class="title">Просмотр Меню</h5>

            <div v-for="(key, index) in daysForDishes" v-if="key">

                <h5 class="title">{{key ? key.name:''}}</h5>

                <q-table :data="forWhatDay(index)"
                         :columns="columns"
                         row-key="name"
                         class="shadow-0"
                         :rows-per-page-options="[0]"
                         :pagination.sync="pagination"
                         hide-bottom
                         :separator="separator"
                >

                    <q-tr slot="body"
                          slot-scope="props"
                          :props="props"
                    >
                        <q-td key="type" :props="props">
                            <span>{{dishType(props.row.type_id)}}</span>
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
                    </q-tr>
                </q-table>


            </div>
            <div class="bth-container">
                <q-btn class="shadow-0 adminMenuBtn"
                       label="Вернутся к Меню"
                       size="md"
                       text-color="white"
                       rounded
                       flat
                       @click="backToMenu"
                />
            </div>
        </q-page>
    </q-layout>
</template>

<style>
    #showMenu {
        max-width: 1300px;
        width: auto;
        min-width: auto;
        overflow: hidden;
    }

    #showMenu .q-table-container {
        width: auto;
    }


    #showMenu .title {
        text-align: center;
        font-style: normal;
        font-weight: bold;
        font-size: 16px;
        line-height: 29px;
        color: #0C4CBC;
        text-transform: capitalize;
        padding: 0;
        margin: 25px 0;
        width: auto;
    }

    #showMenu > .title {
        text-align: center;
        font-style: normal;
        font-weight: bold;
        font-size: 16px;
        line-height: 29px;
        color: #0C4CBC;
        text-transform: capitalize;
        padding: 0;
        margin: 0;
    }

    #showMenu thead tr {
        height: 40px;
    }

    #showMenu thead tr th,
    #showMenu tbody tr td {
        border: 1px solid #d6d6d8;
    }

    /*размеры колонок*/
    /*тип*/
    #showMenu tbody tr td:nth-child(1),
    #showMenu thead tr th:nth-child(1) {
        width:     80px;
        max-width: 100px;
        min-width: auto;
    }
    /*наименование*/
    #showMenu tbody tr td:nth-child(2),
    #showMenu thead tr th:nth-child(2) {
        width:     210px;
        max-width: 210px;
        min-width: auto;
    }
    /*состав*/
    #showMenu tbody tr td:nth-child(3),
    #showMenu thead tr th:nth-child(3) {
        width:     200px;
        max-width: 400px;
        min-width: auto;
    }
    /*калории*/
    #showMenu tbody tr td:nth-child(4),
    #showMenu thead tr th:nth-child(4) {
        width:     100px;
        max-width: 100px;
        min-width: auto;
    }
    /*количество*/
    #showMenu tbody tr td:nth-child(5),
    #showMenu thead tr th:nth-child(5) {
        width:     120px;
        max-width: 120px;
        min-width: auto;
    }
    /*цена*/
    #showMenu tbody tr td:nth-child(6),
    #showMenu thead tr th:nth-child(6) {
        width:     90px;
        max-width: 90px;
        min-width: auto;
    }

    .bth-container { /*контейнер для кнопок*/
        padding-top: 40px;
        display: flex;
        justify-content: flex-end;
        width: 100%;
    }
    .bth-container .adminMenuBtn {
        background-color: #3E6DB9;
        float: right;
        margin: 0 0 0 15px;
        padding: 5px 25px;
        text-transform: capitalize;
        font-size: 12px;
    }
    .bth-container .adminMenuBtn .q-btn-inner {
        text-transform: capitalize;
        font-style: normal;
        font-weight: 500;
        font-size: 12px;
        line-height: 13px;
        text-align: center;
    }
</style>

<script>
    import store from '../../store/admin'
    import { mapGetters } from 'vuex'

    export default {
        store,
        data() {
            return {
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
                        align: 'center'
                    },
                    {
                        name: 'name',
                        label: 'Наименование',
                        field: 'name',
                        style: 'text-align: center',
                        align: 'left'
                    },
                    {
                        name: 'info',
                        label: 'Состав',
                        field: 'info',
                        style: 'text-align: center',
                        align: 'left'
                    },
                    {
                        name: 'calories',
                        label: 'Калории',
                        field: 'calories',
                        align: 'center'
                    },
                    {
                        name: 'count',
                        label: 'Количество',
                        field: 'count',
                        align: 'center'
                    },
                    {
                        name: 'price',
                        label: 'Цена',
                        field: 'price',
                        align: 'center'
                    },
                ]
            }
        },
        mounted() {
            store.dispatch('axiosDishes');
            store.dispatch('axiosDishesTypes');
            store.dispatch('axiosDaysForDishes');
        },
        methods: {
            backToMenu() {
                this.$router.replace('/menu');
            },
            dishType: function (type_id) {

                //опеределяем тип блюда для каждого
                for (let key in this.dishesTypes) {
                    if (Number(this.dishesTypes[key].id) === Number(type_id)) {
                        return this.dishesTypes[key].name;
                    }
                }
            },
            forWhatDay(day_num) {

                //нужно отдать блюдо на пришедший день
                let dayMenu = [];
                for (let key in this.dishes) {

                    if ( this.daysForDishes[Number(day_num)].dishes.includes( Number(this.dishes[key].id) ) ) {
                        dayMenu.push( this.dishes[key] );
                    }
                }

                return dayMenu.sort(function(a, b) {
                    if (a.type_id > b.type_id) return 1;
                    if (a.type_id < b.type_id) return -1;
                });;
            }
        },
        computed: {
            ...mapGetters({
                dishes: 'getDishes',
                dishesTypes: 'getDishesTypes',
                daysForDishes: 'getDaysForDishes',
            }),
        }
    }
</script>