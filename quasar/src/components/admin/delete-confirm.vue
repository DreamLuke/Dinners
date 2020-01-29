<template>
    <div class="overlay">
        <div class="popup">
            <div class="head">
                <h4 class="title">Уведомление</h4>
                <img src="../../statics/icons/close.svg" v-on:click="closeNotify()">
            </div>
            <div class="body">
                <span>{{text}}</span>

                <div class="btnContainer">
                    <q-btn class="shadow-0"
                           label="Да"
                           size="md"
                           text-color="white"
                           rounded
                           flat
                           v-on:click="deleteDish"
                    />
                    <q-btn class="shadow-0"
                           label="Нет"
                           size="md"
                           text-color="white"
                           rounded
                           flat
                           v-on:click="closeNotify"
                    />
                </div>

            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "delete-confirm",
        data() {
            return {
                text: '',
                id: ''
            }
        },
        methods: {
            showNotify(text, data) {
                this.$el.style.display = 'block';
                this.text = text;

                this.id = data;
            },
            closeNotify() {
                this.$el.style.display = 'none';
                this.text = '';
            },
            deleteDish() {
                this.$emit('confirmDelete', this.id);
                this.closeNotify();
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
        width: auto;
        min-width: 300px;
        max-width: 500px;
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
        display: grid;
        grid-template-columns: 1fr;
        grid-template-rows: repeat(4, 1fr);
        grid-row-gap: 17px;
        background-color: #fff;
    }
    .popup .body span {
        grid-row: 2/3;
        font-style: normal;
        font-weight: bold;
        font-size: 18px;
        line-height: 29px;
        color: #3E6DB9;
        text-align: center;
        width: 350px;
        margin: 0 auto;
    }
    .btnContainer {
        grid-row: 3/4;
        margin: 0 auto;
        display: grid;
        grid-template-columns: 1fr 1fr;
        grid-column-gap: 20px;
    }
    button {
        background-color: #3E6DB9;
        padding: 11px 45px;
        float: right;
        text-transform: capitalize;
    }
    button .q-btn-inner {
        font-size: 11px;
        margin: 0;
        padding: 0 0;
    }
    button:active {
        box-shadow: none;
    }
</style>