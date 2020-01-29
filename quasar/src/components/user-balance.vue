<template>
    <div class="balance">
        <ul>
            <li>
                <div class="circle">
                    <img src="../statics/icons/money_bag.svg" alt="">
                </div>
                <!--<span>Итого: {{this.$store.state.total[orderDay].toFixed(2)}} грн</span>-->
                <span>Итого: {{ this.total.toFixed(2) }} грн</span>
            </li>
            <li>
                <div class="circle">
                    <img src="../statics/icons/money.svg" alt="">
                </div>
                <span>Остаток: {{ this.balance.toFixed(2) }} грн.</span>
            </li>

            <li>
                <div class="circle">
                    <img src="../statics/icons/money_pig.svg" alt="">
                </div>
                <span>1600 Ккал</span>
            </li>
            <li>
                <div class="circle">
                    <img src="../statics/icons/Dollar.svg" alt="">
                </div>
                <!--<span>Использовано личных средств: {{this.$store.state.usedPersonalBalance[orderDay].toFixed(2)}} грн</span>-->
                <span>Использовано личных средств: {{this.usedPersonalBalance.toFixed(2)}} грн</span>
            </li>
        </ul>
    </div>
</template>

<style>
    .balance {
        position: fixed;
        top: 230px;
        right: 0;
        background-color: #DBDCFC;
        width: 170px;
        height: 279px;
        font-size: 11px;
        padding: 10px 5px;
        z-index: 1;
    }
    .balance ul {
        display: grid;
        grid-template-rows: repeat(4, 25%);
        height: 100%;
    }
    .balance ul li {
        display: flex;
        align-self: center;
        justify-content: center;
        padding: 0 10px 0 20px;
    }
    .balance ul li .circle {
        width: 45px;
        height: 45px;
        background-color: #3E6DB9;
        border-radius: 30px;
        display: flex;
        align-self: center;
        justify-content: center;
        position: absolute;
        left: -25px;
    }
    .balance ul li span {
        text-align: center;
        display: block;
        justify-content: center;
    }
</style>

<script>
    export default {
        name: 'user-balance',
        props: ['total', 'balance', 'usedPersonalBalance'],
        data() {
            return {
            }
        },
        mounted() {
        },
        computed: {
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
        },
    }
</script>
