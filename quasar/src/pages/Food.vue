<template>
      <q-page class="flex flex-center">
          <img alt="Quasar logo" src="~assets/quasar-logo-full.svg">
      </q-page>
</template>

<style>
</style>

<script>
    export default {
        name: 'PageFood',
        data: function () {
            return {
                //urldata: []
            }
        },
        mounted() {
            console.log('Quasar component mounted.');
            this.getFood();
        },
        methods: {
            getFood: function () {
                console.log('foo--ooo-od!!!...');
                // this.$axios.get('http://dinners.loc/get-food')
                this.$axios.get('/get-food')
                    .then((response) => {
                        this.data = response.data,
                        alert('Привет!!! ')
                        // console.log(this.data[0].dishes)

                    })
                    .catch((err) => {
                        alert('Ошибка');
                        console.log(err)
                    })


            },
        }


    }
</script>
