<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail;
use Carbon\Carbon;
use App\Models\StoragePDFDish;

class createPDFDish extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'email:dish';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command description';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return mixed
     */
    public function handle()
    {
        $data = [];

        Mail::send('email.name', $data, function ($message) {
            $message->from('us@example.com', 'Laravel');
            $getDate = Carbon::now()->format('Y-m-d');
            $pdfFileInfo = StoragePDFDish::where('date', $getDate)->get('pdf_dish');

            foreach ($pdfFileInfo as $item) {
                $pdfFile = $item->pdf_dish;
            }

            $message->to('dima.zavgorodniy1@gmail.com');
            $message->attach($pdfFile);
        });

        return 'Email was sent';
    }
}
