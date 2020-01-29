<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('name')->comment('имя');
            $table->string('email')->unique();
            $table->string('email_verified_at')->nullable();
            //для регистрации через google
            $table->string('provider')->nullable();
            $table->string('provider_id')->nullable();
            //end
            //password nullable для google регистрации
            $table->string('password')->nullable();
            //end
            $table->rememberToken();
            $table->string('telegram', 255)->nullable()->unique()->comment('телеграм');
            $table->string('avatar')->nullable()->comment('аватар');
			$table->string('role')->comment('роль пользователя');
			$table->boolean('accessLevel')->default(1)->comment('0 - without access; 1 - user; 2 - admin; 3 - root;	');
			$table->float('balance',8,2)->comment('ежедневная норма');
			$table->float('persanalBalance')->comment('личный баланс');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('users');
    }
}
