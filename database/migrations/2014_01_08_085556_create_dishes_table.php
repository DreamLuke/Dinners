git <?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateDishesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('dishes', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('name')->unique()->comment('название');
            $table->string('composition', 150)->nullable()->comment('состав');
            $table->integer('calories')->default(0)->unsigned()->comment('калории');
            $table->string('weight', 50)->nullable()->comment('граммы/штуки');
            $table->float('price')->comment('цена');
            $table->integer('type_id')->unsigned()->comment('тип');
            $table->foreign('type_id')->references('id')->on('dishesTypes');
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
        Schema::dropIfExists('dishes');
    }
}
