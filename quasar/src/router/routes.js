import storageUser from '../middleware/storageUser'

const routes = [
    {
        path: '/',
        component: () => import('layouts/MyLayout.vue'),
        children: [
            {
                path: '/',
                component: () => import('pages/Index.vue'),
                beforeEnter: ((to, from, next) => {

                    storageUser().then(data => {

                        if (!data || data.accessLevel < 1) {

                            next();

                        } else if (data.role === 'user') {

                            next('/dish_order');

                        } else if (data.role === 'admin') {

                            next('/adm_purchase_history');
                        }
                    });
                })
            },
            {
                path: '/usr_purchase_history',
                component: () => import('pages/UserPurchaseHistory.vue'),
                beforeEnter: ((to, from, next) => {

                    storageUser().then(data => {
                        if (data.role === 'user' && data.accessLevel > 0) {
                            next();
                        } else {
                            next('/');
                        }
                    });
                })
            },
            {
                path: '/dish_order',
                component: () => import('pages/DishOrder.vue'),
                beforeEnter: ((to, from, next) => {

                    storageUser().then(data => {
                        if (data.role === 'user' && data.accessLevel > 0) {
                            next();
                        } else {
                            next('/');
                        }
                    });
                })
            },
            {
                path: '/absent_page',
                component: () => import('pages/AbsentPage.vue'),
                beforeEnter: ((to, from, next) => {

                    storageUser().then(data => {
                        if (data.role === 'user' && data.accessLevel > 0) {
                            next();
                        } else {
                            next('/');
                        }
                    });
                })
            },



            //admin
            {
                path: '/adm_purchase_history',
                component: () => import('pages/admin/AdminPurchaseHistory.vue'),
                beforeEnter: ((to, from, next) => {

                    storageUser().then(data => {

                        if (data.role === 'admin' && data.accessLevel > 0) {
                            next();
                        } else {
                            next('/');
                        }
                    });
                })
            },
            {
                path: '/menu',
                component: () => import('pages/admin/Menu.vue'),
                beforeEnter: ((to, from, next) => {

                    storageUser().then(data => {

                        if (data.role === 'admin' && data.accessLevel > 0) {
                            next();
                        } else {
                            next('/');
                        }
                    });
                })
            },
            {
                path: '/menu/onweek',
                component: () => import('pages/admin/MenuOnWeek.vue'),
                beforeEnter: ((to, from, next) => {

                    storageUser().then(data => {

                        if (data.role === 'admin' && data.accessLevel > 0) {
                            next();
                        } else {
                            next('/');
                        }
                    });
                })
            },
            {
                path: '/user_control',
                component: () => import('pages/admin/UsersControl.vue'),
                beforeEnter: ((to, from, next) => {

                    storageUser().then(data => {

                        if (data.role === 'admin' && data.accessLevel > 0) {
                            next();
                        } else {
                            next('/');
                        }
                    });
                })
            },
            {
                path: '/dishes_rates',
                component: () => import('pages/admin/DishRate.vue'),
                beforeEnter: ((to, from, next) => {

                    storageUser().then(data => {

                        if (data.role === 'admin' && data.accessLevel > 0) {
                            next();
                        } else {
                            next('/');
                        }
                    });
                })
            },
            {
                path: '/journal',
                component: () => import('pages/admin/Journal.vue'),
                beforeEnter: ((to, from, next) => {

                    storageUser().then(data => {

                        if (data.role === 'admin' && data.accessLevel > 0) {
                            next();
                        } else {
                            next('/');
                        }
                    });
                })
            },
            {
                path: '/product_calendar',
                component: () => import('pages/admin/ProductCalendar.vue'),
                beforeEnter: ((to, from, next) => {

                    storageUser().then(data => {

                        if (data.role === 'admin' && data.accessLevel > 0) {
                            next();
                        } else {
                            next('/');
                        }
                    });
                })
            },
        ]
    }
];

// Always leave this as last one
if (process.env.MODE !== 'ssr') {
  routes.push({
    path: '*',
    component: () => import('pages/Error404.vue')
  })
}

export default routes
