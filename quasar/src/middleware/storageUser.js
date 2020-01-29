import store from '../store'

export default async function storageUser () {

    return await store().dispatch('axiosUser');
}