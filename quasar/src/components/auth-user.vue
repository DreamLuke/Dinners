<template>
    <q-item class="user">
        <q-item-side/>
        <img class="left_menu_icon avatar" :src="this.$store.getters.getUser.avatar">
        <div class="userContainer">

            <!--переключатель отображается, если в бд есть такой флаг-->
            <q-btn-dropdown :label="this.$store.getters.getUser.name"
                            class="shadow-0"
                            no-ripple
                            v-if="Number(this.$store.getters.getUser.accessLevel) > 1"
            >
                <q-list>
                    <q-item>
                        <q-item-main>
                            <q-item-tile label>

                                <template v-if="this.$store.getters.getUser.role === 'user'">
                                     <span @click="profileSwitch()">
                                         Администратор
                                     </span>
                                </template>

                                <template v-if="this.$store.getters.getUser.role === 'admin'">
                                      <span @click="profileSwitch()">
                                          Пользователь
                                      </span>
                                </template>

                            </q-item-tile>
                        </q-item-main>
                    </q-item>
                </q-list>
            </q-btn-dropdown>
            <q-item-main v-else :label="this.$store.getters.getUser.name"/>

            <q-item-main :label="'ID: ' + this.$store.getters.getUser.id"/>
        </div>

        <q-item-main v-if="this.$store.getters.getUser.role === 'user'"
                 :label="'Личный баланс: ' + this.$store.state.personalBalance.toFixed(2) + ' грн'"/>
    </q-item>
</template>

<script>
    import axios from 'axios'

    export default {
        name: 'AuthUser',
            data () {
                return {

                }
            },
        methods: {
            profileSwitch() {

                axios.patch('/profile', {id : Number(this.$store.getters.getUser.id)})
                    .then(response => {

                        location.reload()
                    })
                    .catch(error => {
                        console.error(error);
                    })
            }
        }
    }
</script>

<style scoped>
    .q-btn {
        background: inherit;
        color: #fff;
        padding-right: 0;
        text-transform: capitalize;
        font-weight: bold;
        font-size: 14px;
    }
    .q-btn:hover {
        background: inherit;
        filter: none;
    }
    .q-popover .q-list {
        padding: 0;
        margin: 0;
    }
    .q-popover .q-item:hover {
        background-color: rgba(204, 204, 204, 0.36) !important;
    }
    .q-popover .q-item {
        cursor: pointer;
        padding: 0;
        margin: 0;
        height: 40px;
    }
    .q-popover .q-item .q-item-main {
        padding: 0;
        margin: 0;
    }
    .q-item-label {
        user-select: none;
        color: #000;
    }
    .q-item-label span {
        display: block;
        height: 40px;
        padding: 12px 0 0 33px;
        color: #4b4b4b;
        background: url("../statics/icons/switch.png") no-repeat 8px 8px;
    }
</style>