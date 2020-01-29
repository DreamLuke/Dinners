<template>
    <div class="overlay">
        <div class="popup">
            <div class="head">
                <h4 class="title">Уведомление</h4>
                <img src="../statics/icons/close.svg" v-on:click="closeNotify()">
            </div>
            <div class="body">
                <span>{{text}}</span>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "notify-popup",
        data() {
            return {
                text: ''
            }
        },
        methods: {
            showNotify(text) {
                this.$el.style.display = 'block';
                this.text = text;

            },
            closeNotify() {
                this.$el.style.display = 'none';
                this.text = '';
            }
        }
    }
</script>

<style scoped>
    .overlay {
        position: fixed;
        left: 0;
        top: 0;
        background-color: transparent;
        width: 100%;
        height: 100%;
        display: none;
        z-index: 1;
    }
    .popup {
        position: relative;
        max-width: 830px;
        height: 190px;
        margin: 0 auto;
        top: 35vh;
        overflow: hidden;
        border: 1px solid #043DA0;
        box-shadow: 0 4px 4px rgba(0, 0, 0, 0.25), 0 4px 4px rgba(0, 0, 0, 0.25);
    }
    .popup .head {
        position: absolute;
        height: 38px;
        width: 100%;
        background-color: #136598;
        padding: 0 10px 0 18px;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }
    .popup .head .title {
        padding: 0;
        margin: 0;
        font-style: normal;
        font-weight: bold;
        font-size: 18px;
        line-height: 29px;
        color: #FFFFFF;
    }
    .popup .head img {
        cursor: pointer;
    }
    .popup .body {
        position: absolute;
        top: 38px;
        left: 0;
        width: 100%;
        height: 80%;
        display: flex;
        justify-content: center;
        align-items: center;
        background-color: #fff;
    }
    .popup .body span {
        font-style: normal;
        font-weight: bold;
        font-size: 18px;
        line-height: 29px;
        color: #3E6DB9;
        text-align: center;
        width: 350px;
    }
</style>