<template>
  <q-page>
      <q-card square
              text-color="blue-10">
          <q-card-title>
              <span>Чтобы заказать обед, пожалуйста, авторизируйтесь</span>
          </q-card-title>
          <q-card-main>

              <template v-if="!this.$store.getters.getUser">
                  <img onclick="location.href='/auth/google'" src="../statics/icons/google.svg">
              </template>
              <template v-else>
                  <img onclick="location.reload()" src="../statics/icons/google.svg">
              </template>


          </q-card-main>
      </q-card>
      <no-access v-if="this.$store.getters.getUser.accessLevel < 1"></no-access>
  </q-page>
</template>

<style>
    .q-layout-page {
        padding-top: 25vh;
    }
    .q-card {
        max-width: 440px;
        width: 100%;
        height: 300px;
        text-align: center;
        padding: 40px 20px;
        box-shadow: 0 4px 4px rgba(0, 0, 0, 0.25);
        background-color: #E7E7E7;
        margin: auto;
    }
    .q-card-container {
        padding: 0;
    }
    .q-card-title {
        font-style: normal;
        font-weight: 500;
        font-size: 25px;
        line-height: 30px;
        text-align: center;
        color: #043DA0;
        margin-bottom: 25px;
    }
    .q-card-main img {
        transition: 0.25s;
        display: block;
        margin: 0 auto;
        cursor: pointer;
    }
    .q-card-main img:hover {
        filter: opacity(0.85);
    }
</style>

<script>
    import NoAccess from '../components/no-access'

    export default {
        name: 'PageIndex',
        components: {NoAccess}
    }
</script>
