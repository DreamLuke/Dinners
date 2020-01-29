<template>
    <div class="overlay">
        <div class="popup">

            <div class="head">
                <h4 class="title">Пополнение личного баланса</h4>
                <img src="../../statics/icons/close.svg" @click="donutClose">
            </div>
            <div class="body">

                <q-input v-model="user.name"
                         color="grey-3"
                         inverted-light
                         placeholder="Имя пользователя"
                         class="shadow-0"
                         readonly
                />

                <input v-model.lazy="price"
                       :class="error"
                       placeholder="Введите сумму пополнения"
                       id="mask"
                       maxlength="6"
                />

                <q-btn class="shadow-0"
                       label="Сохранить"
                       size="md"
                       text-color="white"
                       rounded
                       flat
                       @click="donutSave"
                />

            </div>
        </div>
    </div>
</template>


<style scoped>
    .wrongInput {
        box-shadow: inset 0 0 3px red !important;
    }
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
        height: 230px;
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
        height: 84%;
        padding: 15px 25px 15px 25px;

        display: grid;
        grid-template-columns: repeat(3, 1fr);
        grid-template-rows: repeat(3, 1fr);
        grid-row-gap: 15px;
        background-color: #fff;
    }
    .q-input, input {
        height: 40px;
    }
    .q-input {
        grid-column: 1/4;
        grid-row: 1/2;
        font-size: 14px;
    }
    input {
        grid-column: 1/4;
        grid-row: 2/3;
        border: none;
        background-color: #eeeeee;
        border-radius: 5px;
        padding: 5px 8px;
        font-size: 14px;
    }
    input::placeholder {
        color: #555555;
    }
    button {
        grid-column: 3/4;
        grid-row: 3/4;
        background-color: #3E6DB9;
        text-transform: capitalize;
        font-size: 12px !important;
        width: 130px;
        margin: 3px 0 0 20px;
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


<script>
    export default {
        name: 'donate-popup',
        data() {
            return {
                user: '',
                price: '',
                error: '',
            }
        },
        methods: {
            donutOpen(usersData) {
                this.clearValues();

                this.$el.style.display = 'block';
                this.user = usersData;

                $('#mask').mask('##.##00.00', {reverse: true});
            },
            donutClose() {

                this.clearValues();
                this.$el.style.display = 'none';
            },
            donutSave() {

                let pattern = /^([0-9]{1,2})$|^([0-9]{1,3})([.]{1})([0-9]{2})$/ ;

                if (!pattern.test(this.price)) {

                    this.error = 'wrongInput';
                } else {

                    this.error = '';
                    this.$emit('makeDonut', this.user, this.price);
                    this.clearValues();
                    this.donutClose();
                }
            },
            clearValues() {

                for (let key in this.$data) {

                    this.$data[key] = '';
                }
            }
        }
    }
</script>

