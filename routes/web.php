<?php

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    echo file_get_contents(public_path('quasar/index.html'));
});

Auth::routes();

Route::get('/get-user-info', 'UserController@getUserInfo')->name('get-user-info');

Route::get('/auth/{provider}', 'Auth\LoginController@redirectToProvider')->name('auth-google');
Route::get('auth/{provider}/callback', 'Auth\LoginController@handleProviderCallback')->name('auth-google-callback');
Route::post('/auth/logout', 'Auth\LoginController@logout');

Route::get('/get-absent-info', 'AbsentInfoController@getAbsentInfo')->name('get-absent-info');
Route::get('/get-reasons', 'AbsentInfoController@getReasons');
Route::get('/get-absences', 'AbsentInfoController@getAbsences');
Route::post('/absent-info', 'AbsentInfoController@store')->name('absent-info');
Route::get('/get-reasons', 'AbsentInfoController@getReasons')->name('get-reasons');

Route::post('/get-order-date', 'PurchaseHistoryController@getOrderFromDate')->name('get-order-date');
Route::post('/get-requirements', 'PurchaseHistoryController@getRequirements')->name('get-requirements');
Route::post('/get-bake', 'PurchaseHistoryController@getOrdersForBake')->name('get-bake');
Route::get('/get-order-info', 'PurchaseHistoryController@getOrderFromDate')->name('get-order-info');
Route::post('/get-order-by-user', 'PurchaseHistoryController@getOrderForDateByUser');

Route::post('/generate-pdf-dish', 'PDFController@generatePDFDish');
Route::post('/generate-pdf-bake', 'PDFController@generatePDFBake');

Route::get('/get-requirements', 'RequirementController@index')->name('get-requirements');

Route::get('/get-dishes', 'DishController@index')->name('get-dishes');
Route::get('/get-days-for-dishes', 'DishController@getDaysForDishes')->name('get-days-for-dishes');
Route::get('/get-dishes-types', 'DishController@getDishesTypes')->name('get-dishes-types');
Route::get('/get-dishes-to-requirements', 'DishController@getDishesToRequirements')->name('get-dishes-to-requirements');

Route::get('/orders', 'OrderController@index');
Route::post('/orders', 'OrderController@store');
Route::get('/get-today-day-of-week', 'OrderController@getTodayDayOfWeek');
Route::get('/get-dates', 'OrderController@getDates');
Route::get('/get-orders-to-week', 'OrderController@getOrdersToWeek');
Route::get('/get-order-sum/{id}', 'OrderController@getOrderSum');
Route::post('/get-order-for-date', 'OrderController@getOrderForDate');
Route::delete('/orders/{id}', 'OrderController@destroy');

Route::patch('/profile', 'Control\AccessController@profile');

Route::prefix('/control')->group(function () {
    Route::put('/create', 'Control\UsersController@create');
    Route::delete('/destroy','Control\UsersController@destroy');

    Route::patch('/donate', 'Control\AccessController@donate');
    Route::get('/users', 'UserController@getUsers');
    Route::patch('/user', 'Control\AccessController@user');
    Route::patch('/admin', 'Control\AccessController@admin');
});
Route::prefix('/menu')->group(function () {
    Route::put('/create', 'Menu\DishesController@create');
    Route::put('/update', 'Menu\DishesController@update'); //добавить блюдо в меню
    Route::delete('/destroy', 'Menu\DishesController@destroy');
});
Route::prefix('/menu/type')->group(function () {
    Route::post('/create', 'Menu\DishesTypeController@create');
    Route::patch('/update', 'Menu\DishesTypeController@update');
    Route::delete('/destroy', 'Menu\DishesTypeController@destroy');
});
Route::prefix('/journal')->group(function () {
    Route::post('/create', 'Journal\AbsenceController@create');
    Route::patch('/update', 'Journal\AbsenceController@update');
    Route::delete('/destroy', 'Journal\AbsenceController@destroy');
});
Route::prefix('/journal/type')->group(function () {
    Route::post('/create', 'Journal\AbsenceTypeController@create');
    Route::patch('/update', 'Journal\AbsenceTypeController@update');
    Route::delete('/destroy', 'Journal\AbsenceTypeController@destroy');
});

Route::post('/get-info-for-diagram', 'DiagramController@getInfoForDiagram')->name('get-info-for-diagram');
Route::get('/get-types-for-diagram', 'DiagramController@getDishTypeForDiagram')->name('get-types-for-diagram');

Route::post('/post-weekend-date', 'WorkCalendarController@store');
Route::get('/get-weekend-days', 'WorkCalendarController@index');