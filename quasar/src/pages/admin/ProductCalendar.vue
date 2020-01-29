<template>
    <q-page padding>
    <!--<div style="overflow: hidden">-->
        <!--<p class="date">Выберите дату:</p>-->
        <!--<q-datetime class="datetime" format="YYYY"/>-->
    <!--</div>-->
    <YearCalendar
            v-model="year"
            :activeDates.sync="activeDates"
            @toggleDate="submitWeekendDate"
            @destroy="deleteWeekendDay"
            prefixClass="your_customized_wrapper_class"
            :activeClass="activeClass"
    ></YearCalendar>
    </q-page>
</template>


<style lang="stylus">
    .your_customized_wrapper_class {
        background-color: #0aa;
        color: white;
    }

    &.red {
        background-color: red;
        color: white;
    }

    &:after {
        /*background-image url('./assets/baseline-remove_circle-24px.svg');*/
        background-size 100% 100%;
    }

    &.blue {
         background-color: #0000aa;
         color: white;
     }
    &.your_customized_classname {
         background-color: yellow;
         color: black;
     }


</style>

<script>
    import YearCalendar from 'vue-material-year-calendar'

    export default {
        components: { YearCalendar },
        data () {
            return {
                year: 2019,
                chooseDate: '',
                activeDates: [],
                activeClass: 'red',
            }
        },
        mounted() {
            this.getWeekendDays()
        },
        methods: {
            toggleDate (dateInfo) {
                this.activeDates = dateInfo;
            },
            submitWeekendDate() {
                this.$axios.post('/post-weekend-date', {
                    activeDates: this.activeDates,
                }).then(response => {
                    this.getWeekendDays();
                })
                .catch((error) => {
                })
            },
            getWeekendDays() {
                this.$axios.get('/get-weekend-days')
                    .then((response) => {
                        this.data = response.data;
                        this.activeDates = response.data;
                    })
                    .catch((err) => {
                        console.log(err)
                    })
            },
            deleteWeekendDay() {
                this.$axios.get('/delete-weekend-days')
                    .then((response) => {
                    })
                    .catch((err) => {
                        console.log(err)
                    })
            },
        }
    }
</script>