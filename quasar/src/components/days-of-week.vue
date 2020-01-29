<template>
    <div class="q-table-container shadow-0" id="daysOfWeek">
        <div class="q-table-middle">
            <table class="q-table">
                <tbody>
                <tr id="daysWeek">
                    <td class="text-center">
                        <img src="../statics/icons/calendar.svg">
                    </td>
                    <td class="text-center" v-for="(day, index) in days" :key="day.name">
                        <div class="activeDay" @click="showMenu(index)">
                            <span>{{day.date}}</span>
                            <span :class="day.active">{{day.name}}</span>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</template>

<style scoped>

    #daysOfWeek tr {
        position: relative;
    }
    #daysOfWeek tr td:first-child {
        padding: 0 10px 0 0;
    }
    #daysOfWeek tr:hover {
        background-color: inherit;
    }
    #daysOfWeek tr td {
        color: #136598;
        font-weight: bold;
        font-size: 14px;
        line-height: 18px;
        padding: 0 15px;
    }
    #daysOfWeek span {
        cursor: pointer;
        font-size: 14px;
        user-select: none;
        display: block;
        padding: 0 2px;
    }
    #daysOfWeek .active {
        padding: 5px;
        border-radius: 5px;
        background-color: #DBDCFC;
        box-sizing: border-box;
    }
    #daysOfWeek .slider {
        border-bottom: 3px solid #136598;
        margin-bottom: -3px;
    }
    #daysOfWeek .active .slider {

    }
    #daysOfWeek .activeDay {

    }
</style>
<script>
    let orderDay = new Date().getDay() + 1;
    // let orderDay = 1;

    export default {
        name: 'days-of-week',
        data() {
            return {
                days: [
                    {name: 'Понедельник', date: '', active: ''},
                    {name: 'Вторник',     date: '', active: ''},
                    {name: 'Среда',       date: '', active: ''},
                    {name: 'Четверг',     date: '', active: ''},
                    {name: 'Пятница',     date: '', active: ''}
                ],
            }
        },
        mounted() {
            //подсвечиваем день на который будет сделан заказ
            let daysWeek = document.querySelectorAll('#daysWeek td');

            this.$axios.get('/get-dates')
                .then((response) => {
                    this.$store.state.today = response.data;
                    this.$store.state.orderWeekDates = response.data;

                    for (let key in daysWeek) {
                        if (isFinite(key)) {

                            // this.days[key].name = this.days[key].name + ' ' + this.$store.state.today['день недели'] + '_' + this.$store.state.today['число'] + '.' + this.$store.state.today['месяц'] + '.' + this.$store.state.today['год'];

                            //заказ нельзя сделать на субботу и воскресенье
                            if (orderDay > 5) {
                                daysWeek[1].classList.add('active');

                                //по-умолчанию подсвечено меню на день заказа
                                this.days[0].active = 'slider';
                                // this.days[0].name = this.days[0].name + ' ' + this.$store.state.today['число'] + '.' + this.$store.state.today['месяц'] + '.' + this.$store.state.today['год'];

                                //отдаём понедельник
                                orderDay = 1;
                                this.$store.state.orderDay = orderDay - 1;

                                // this.days[key].name = this.days[key].name + ' ' + this.$store.state.today['день недели'] + '_' + this.$store.state.today['число'] + '.' + this.$store.state.today['месяц'] + '.' + this.$store.state.today['год'];
                            }

                            if (+key === orderDay) {
                                daysWeek[key].classList.add('active');
                                this.days[key - 1].active = 'slider';
                                this.$store.state.orderDay = orderDay - 1;
                            }

                            let ind = (+key + 1);

                            let dayOfMonth = this.$store.state.orderWeekDates[ind]['число'];
                            if('' + dayOfMonth.charAt(0) == '0') {
                                dayOfMonth = dayOfMonth.charAt(1);
                            }

                            // this.days[key].date = this.$store.state.orderWeekDates[ind]['число'] + '.' + this.$store.state.orderWeekDates[ind]['месяц'];
                            this.days[key].date = dayOfMonth + '.' + this.$store.state.orderWeekDates[ind]['месяц'];
                        }
                    }

                    //по загрузке компонента - вернуть текущий индекс и день заказа
                    for (let key in this.days) {
                        if (this.days[key].active === 'slider') {
                            this.showMenu(key, orderDay);
                        }
                    }
                }).catch((err) => {
                console.log('Ошибка' + err)
            })




            /*for (let key in daysWeek) {
                if (isFinite(key)) {
                    //заказ нельзя сделать на субботу и воскресенье
                    if (orderDay > 5) {
                        daysWeek[1].classList.add('active');

                        //по-умолчанию подсвечено меню на день заказа
                        this.days[0].active = 'slider';

                        //отдаём понедельник
                        orderDay = 1;
                    }

                    if (+key === orderDay) {
                        daysWeek[key].classList.add('active');
                        this.days[key - 1].active = 'slider';
                    }
                }
            }

            //по загрузке компонента - вернуть текущий индекс и день заказа
            for (let key in this.days) {
                if (this.days[key].active === 'slider') {
                    this.showMenu(key, orderDay);
                }
            }*/
        },
        methods: {

            //по нажатию на компонент - подчёркивать и возвращать день
            showMenu(index) {
                for (let key in this.days) {
                    this.days[key].active = '';
                }
                this.days[index].active = 'slider';

                //возвращаю день
                this.$emit('sendDay', orderDay - 1, index);
            }
        }
    }
</script>
