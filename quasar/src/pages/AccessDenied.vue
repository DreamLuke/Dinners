<template>
    <q-layout>
        <q-page padding>

            <no-access></no-access>

        </q-page>
    </q-layout>
</template>

<script>
    import NoAccess from '../components/no-access'

    export default {
        name: "access-denied",
        components: {NoAccess}
    }
</script>

<style scoped>

</style>