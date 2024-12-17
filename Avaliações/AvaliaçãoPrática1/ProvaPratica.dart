// Feito por Victor Moura 
import 'dart:io';
import 'dart:async';
import 'package:sqlite3/sqlite3.dart';


Future<void> main() async {
  // Imprimir o nome conforme solicitado
  print("nome: Victor Moura André");

  // Abrir banco de dados persistente
  final db = sqlite3.open('banco_de_dados.db');

  // Criar a tabela (se não existir)
  db.execute('''
    CREATE TABLE IF NOT EXISTS alunos (
      id INTEGER NOT NULL PRIMARY KEY,
      nome TEXT NOT NULL,
      idade INTEGER NOT NULL
    );
  ''');

  // Limpar a tabela para evitar duplicação em execuções subsequentes
  db.execute('DELETE FROM alunos');

  // Inserir dados de forma assíncrona (verificando se o aluno já existe)
  await inserirAluno(db, 'Victor Moura', 17);
  await inserirAluno(db, 'Maria Eduarda', 17);

  // Consultar dados de forma assíncrona
  await consultarAlunos(db);

  // Atualizar dados de forma assíncrona
  await atualizarAluno(db, 1, 'Maria Eduarda Modificado', 18);

  // Excluir dados de forma assíncrona
  await excluirAluno(db, 2);

  // Consultar dados novamente após atualização e exclusão
  await consultarAlunos(db);

  // Fechar o banco de dados
  db.dispose();
}

// Função para inserir um aluno de forma assíncrona
Future<void> inserirAluno(Database db, String nome, int idade) async {
  // Verificar se o aluno já existe no banco de dados
  final result = db.select(
      'SELECT * FROM alunos WHERE nome = ? AND idade = ?', [nome, idade]);
  if (result.isEmpty) {
    // Se o aluno não existe, inserir no banco de dados
    final stmt = db.prepare('INSERT INTO alunos (nome, idade) VALUES (?, ?)');
    await Future.delayed(
        Duration(milliseconds: 50)); // Simulação de delay assíncrono
    stmt.execute([nome, idade]);
    stmt.dispose();
  } else {
    print('Aluno $nome já existe no banco de dados!');
  }
}

// Função para consultar todos os alunos de forma assíncrona
Future<void> consultarAlunos(Database db) async {
  final resultSet = db.select('SELECT * FROM alunos');
  print('Consultando alunos:');
  for (final row in resultSet) {
    print(
        'Aluno[id: ${row['id']}, nome: ${row['nome']}, idade: ${row['idade']}]');
  }
}

// Função para atualizar dados de um aluno de forma assíncrona
Future<void> atualizarAluno(Database db, int id, String nome, int idade) async {
  final stmt = db.prepare('UPDATE alunos SET nome = ?, idade = ? WHERE id = ?');
  await Future.delayed(
      Duration(milliseconds: 50)); // Simulação de delay assíncrono
  stmt.execute([nome, idade, id]);
  stmt.dispose();
}

// Função para excluir um aluno de forma assíncrona
Future<void> excluirAluno(Database db, int id) async {
  final stmt = db.prepare('DELETE FROM alunos WHERE id = ?');
  await Future.delayed(
      Duration(milliseconds: 50)); // Simulação de delay assíncrono
  stmt.execute([id]);
  stmt.dispose();
}
