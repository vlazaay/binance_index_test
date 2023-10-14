<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class Dbdrop extends Command
{
    protected $signature = 'db:drop {name?}';

    protected $description = 'Drop a MySQL database based on the provided name';

    public function __construct()
    {
        parent::__construct();
    }

    public function handle(): void
    {
        $schemaName = $this->argument('name') ?: config('database.connections.mysql.database');

        if (! $schemaName) {
            $this->error('Please provide the name of the database to drop.');

            return;
        }

        try {
            DB::connection()->getPdo()->exec("USE $schemaName");
        } catch (\Exception $e) {
            $this->info("Database '$schemaName' does not exist.");

            return;
        }

        $query = "DROP DATABASE IF EXISTS $schemaName;";

        DB::statement($query);

        $this->info("Database '$schemaName' has been dropped.");
    }
}
