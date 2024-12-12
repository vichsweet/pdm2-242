import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

class Aluno {
  int? id;
  String nome;
  String dataNascimento;

  Aluno({this.id, required this.nome, required this.dataNascimento});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'data_nascimento': dataNascimento,
    };
  }
}

class AlunoDatabase {
  static final AlunoDatabase instance = AlunoDatabase._init();

  static Database? _database;

  AlunoDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('aluno.db');
    return _database!;
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await databaseFactoryFfi.getDatabasesPath();
    final path = join(dbPath, dbName);

    return await databaseFactoryFfi.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE TB_ALUNOS (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              nome TEXT NOT NULL,
              data_nascimento TEXT NOT NULL
            )
          ''');
        },
      ),
    );
  }

  Future<int> insertAluno(Aluno aluno) async {
    final db = await database;
    return db.insert('TB_ALUNOS', aluno.toMap());
  }

  Future<List<Aluno>> getAllAlunos() async {
    final db = await database;
    final result = await db.query('TB_ALUNOS');
    return result.map((map) => Aluno(
      id: map['id'] as int?,
      nome: map['nome'] as String,
      dataNascimento: map['data_nascimento'] as String,
    )).toList();
  }
}

void main() async {
  // Inicializa o driver FFI
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  // Configuração do banco de dados
  final db = AlunoDatabase.instance;

  // Inserir exemplo
  await db.insertAluno(Aluno(nome: 'Vitoria', dataNascimento: '2007-09-15'));

  // Listar todos os alunos
  final alunos = await db.getAllAlunos();
  for (var aluno in alunos) {
    print('Aluno: ${aluno.nome}, Nascimento: ${aluno.dataNascimento}');
  }
}
