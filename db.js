import pg from 'pg';

const { Pool } = pg;

// Configuração das credenciais de acesso ao PostgreSQL local
const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'GestaoClientes',
    password: 'amods',
    port: 7777,
});

export default pool;
