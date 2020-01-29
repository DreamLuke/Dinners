<template>
    <q-page padding>
        <div style="overflow: hidden">
            <p class="date">Выберите дату:</p>
            <p class="rangeText">с</p>
            <q-datetime class="datetime" format="DD.MM.YYYY" v-model="date"/>
            <p class="rangeText">по</p>
            <q-datetime class="datetime" :min="date" format="DD.MM.YYYY" v-model="dateSecondInRange"/>
        </div>
        <div style="overflow: hidden;">
            <p class="date">Выберите тип блюда:</p>
            <q-select class="datetime"
                      v-model="dish_type"
                      :options="options"
            />
        </div>
        <div class="btn">
            <q-btn @click="getInfoForDiagram" class="btn_absent shadow-0" label="Просмотр" />
        </div>
        <GChart
                type="PieChart"
                :data="chartData"
                :options="chartOptions"
                class="diagram"
        />
    </q-page>
</template>

<style scoped>
    .btn {
        margin-top: -20px;
        width: 320px;
    }
</style>

<style>
    .diagram {
        width: 800px;
        height: 400px;
        margin-top: 100px;
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
        margin-left: 20px;
        background: #FFFFFF;
        border: 1px solid #043DA0;
        border-radius: 5px;
        /*max-width: 500px;*/
        height: 20px;
        font-style: normal;
        font-weight: normal;
        font-size: 12px;
        color: #043DA0;
    }
    .range {
        font-style: normal;
        font-weight: 500;
        font-size: 12px;
        line-height: 29px;/* identical to box height, or 242% */
        color: #043DA0;
        margin-top: -20px;
        cursor: pointer;
        width: 140px;
    }
    .q-input-target {
        margin-left: 10px;
    }
    div .scroll {
        width: 300px;
        overflow: inherit;
    }
    main {
        width: 100%;
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
        margin-left: 20px;
        background: #FFFFFF;
        border: 1px solid #043DA0;
        border-radius: 5px;
        /*max-width: 500px;*/
        height: 20px;
        font-style: normal;
        font-weight: normal;
        font-size: 12px;
        color: #043DA0;
    }
    .range {
        font-style: normal;
        font-weight: 500;
        font-size: 12px;
        line-height: 29px;/* identical to box height, or 242% */
        color: #043DA0;
        margin-top: -20px;
        cursor: pointer;
    }
    .rangeText {
        float: left;
        font-style: normal;
        font-weight: bold;
        font-size: 16px;
        color: #0C4CBC;
        margin-left: 20px;
    }
    .q-input-target {
        margin-left: 10px;
    }
    div .scroll {
        width: 300px;
        overflow: inherit;
    }
    main {
        width: 100%;
    }
    .q-popover .q-item-section {
        color: #1b1e21;
    }
    .textarea {
        width: 671px;
        height: 112px;
        background: #FFFFFF;
        border: 1px solid #043DA0;
        box-sizing: border-box;
        box-shadow: 0 4px 4px rgba(0, 0, 0, 0.25);
        resize: none;
        padding: 5px 10px;
    }
    .btn {
        width: 671px;
    }
    .textarea::placeholder {
        color: #173156;
    }
    .btn_absent {
        float: right;
        margin-top: 25px;
        width: 133px;
        height: 34px;
        background: #3E6DB9;
        border-radius: 30px;
        text-transform: capitalize;
    }
    .btn_absent .q-btn-inner {
        font-style: normal;
        font-weight: 500;
        font-size: 11px;
        text-align: center;
        color: #FFFFFF;
    }
</style>

<script>
    import { GChart } from 'vue-google-charts'
    export default {
        components: {
            GChart
        },
        name: 'DishRate',
        data() {
            return {
                date: new Date(new Date().setDate(1)),
                dateSecondInRange: new Date(new Date().getFullYear(), new Date().getMonth()+1, 0),
                dish_type: 1,
                options: [],
                chartData: '',
                chartOptions: {
                    title: '',
                },
            }
        },
        mounted() {
            this.getTypesForDiagram();
        },
        computed: {

        },
        methods: {
            getInfoForDiagram() {
                this.$axios.post('/get-info-for-diagram', {
                    dataType: "json",
                    async: false,
                    date: this.date,
                    dateSecondInRange: this.dateSecondInRange,
                    dish_type: this.dish_type
                }).then(response => {
                    this.chartData = response.data;
                    for (let key in this.chartData) {
                        this.chartData = this.chartData[key];
                    }
                    if (this.dish_type == 1) {
                        return this.chartOptions = { title: 'Рейтинг первых блюд'};
                    } else if (this.dish_type == 2) {
                        return this.chartOptions = { title: 'Рейтинг гарниров'};
                    } else if (this.dish_type == 3) {
                        return this.chartOptions = { title: 'Рейтинг мясных блюд'};
                    } else if (this.dish_type == 4) {
                        return this.chartOptions = { title: 'Рейтинг салатов'};
                    } else if (this.dish_type == 5) {
                        return this.chartOptions = { title: 'Рейтинг выпечки'};
                    } else if (this.dish_type != '') {
                        return this.chartOptions = {title: 'Рейтинг выбранного типа блюда'};
                    }
                })
                .catch((err) => {
                    alert('Ошибка');
                    console.log(err)
                })
            },
            getTypesForDiagram: function () {
                this.$axios.get('/get-types-for-diagram')
                    .then((response) => {
                        this.data = response.data;

                        for (let i = 0; i < response.data.length; i++) {
                            this.options.push(
                                {label: response.data[i]['name'],
                                    value: response.data[i]['id']}
                            )
                        }
                    })
                    .catch((err) => {
                        alert('Ошибка');
                        console.log(err)
                    })
            },
        }
    }
</script>