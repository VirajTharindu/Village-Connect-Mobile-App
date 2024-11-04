import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'family_member.dart'; // Import the FamilyMember model

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  // Getter to access the single instance
  static DatabaseHelper get instance => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'village_officer.db');
    if (kDebugMode) {
      print("Database path: $path");
    } // Add this line for debugging
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE family_members(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            nationalId TEXT UNIQUE,
            birthday TEXT,
            age INTEGER,
            nationality TEXT,
            religion TEXT,
            educationQualification TEXT,
            jobType TEXT,
            isSamurdiAid INTEGER,
            isAswasumaAid INTEGER,
            isWedihitiAid INTEGER,
            isMahajanadaraAid INTEGER,
            isAbhadithaAid INTEGER,
            isShishshyadaraAid INTEGER,
            isPilikadaraAid INTEGER,
            isAnyAid INTEGER,
            householdNumber TEXT,
            familyHeadType TEXT,
            relationshipToHead TEXT,
            grade TEXT
          )
          ''',
        );
      },
      version: 1,
    );
  }

  // Insert a FamilyMember record into the database
  Future<void> insertFamilyMember(FamilyMember member) async {
    final db = await database;
    await db.insert(
      'family_members',
      member.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    if (kDebugMode) {
      print("Inserted family member: ${member.toMap()}");
    } // Debugging line
  }

  // Retrieve all FamilyMember records from the database
  Future<List<FamilyMember>> retrieveFamilyMembers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('family_members');

    return List.generate(maps.length, (i) {
      return FamilyMember.fromMap(maps[i]);
    });
  }

  // Retrieve FamilyMember records by household number
  Future<List<FamilyMember>> retrieveFamilyMembersByHousehold(
      String householdNumber) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'family_members', // Change this to your actual table name
      where: 'householdNumber = ?',
      whereArgs: [householdNumber],
    );

    return List.generate(maps.length, (index) {
      return FamilyMember.fromMap(maps[index]);
    });
  }

  // Method to query families receiving Samurdhi aid
  Future<List<Map<String, dynamic>>> querySamurdhiFamilies() async {
    final db = await database; // Get a reference to the database

    // Query the family_data table where isSamurdiAid is true (1)
    return await db
        .query('family_members', where: 'isSamurdiAid = ?', whereArgs: [1]);
  }

  // Method to query families receiving Aswasuma aid
  Future<List<Map<String, dynamic>>> queryAswasumaFamilies() async {
    final db = await database;
    return await db.query(
      'family_members',
      where: 'isAswasumaAid = ?',
      whereArgs: [1], // Assuming 1 means receiving Aswasuma aid
    );
  }

  /// Method to query families receiving Wedihiti aid
  Future<List<Map<String, dynamic>>> queryWedihitiFamilies() async {
    final db = await database;

    // Query the family_members table where isWedihitiAid is 1
    return await db.query(
      'family_members',
      where: 'isWedihitiAid = ?',
      whereArgs: [1], // Assuming 1 indicates receiving Wedihiti aid
    );
  }

  /// Method to query families receiving Mahajanadara aid
  Future<List<Map<String, dynamic>>> queryMahajanadaraFamilies() async {
    final db = await database;

    // Query the family_members table where isMahajanadaraAid is 1
    return await db.query(
      'family_members',
      where: 'isMahajanadaraAid = ?',
      whereArgs: [1], // Assuming 1 indicates receiving Mahajanadara aid
    );
  }

  /// Method to query families receiving Abhaditha aid
  Future<List<Map<String, dynamic>>> queryAbhadithaFamilies() async {
    final db = await database;

    // Query the family_members table where isAbhadithaAid is 1
    return await db.query(
      'family_members',
      where: 'isAbhadithaAid = ?',
      whereArgs: [1], // Assuming 1 indicates receiving Abhaditha aid
    );
  }

  /// Method to query families receiving Shishshyadara aid
  Future<List<Map<String, dynamic>>> queryShishshyadaraFamilies() async {
    final db = await database;

    // Query the family_members table where isShishshyadaraAid is 1

    return await db.query(
      'family_members',
      where: 'isShishshyadaraAid = ?',
      whereArgs: [1], // Assuming 1 indicates receiving Shishshyadara aid
    );
  }

  /// Method to query families receiving Pilikadara aid
  Future<List<Map<String, dynamic>>> queryPilikadaraFamilies() async {
    final db = await database;

    // Query the family_members table where isPilikadaraAid is 1
    return await db.query(
      'family_members',
      where: 'isPilikadaraAid = ?',
      whereArgs: [1], // Assuming 1 indicates receiving Pilikadara aid
    );
  }

  /// Method to query families receiving any kind of aid
  Future<List<Map<String, dynamic>>> queryAnyAidFamilies() async {
    final db = await database;

    // Query the family_members table where isAnyAid is 1
    return await db.query(
      'family_members',
      where: 'isAnyAid = ?',
      whereArgs: [1], // Assuming 1 indicates receiving any kind of aid
    );
  }

  Future<List<Map<String, dynamic>>> queryAllStudentFamilyMembers() async {
    final db = await database; // Get the database instance

    // Define the grades you want to filter by
    final List<String> validGrades =
        List.generate(13, (index) => (index + 1).toString());

    // Convert the list of valid grades into a comma-separated string for the SQL query
    final String validGradesString =
        validGrades.map((grade) => "'$grade'").join(', ');

    // Query the database for family members with grades between 1 and 13
    return await db.rawQuery(
        'SELECT * FROM family_members WHERE grade IN ($validGradesString)');
  }

  Future<List<Map<String, dynamic>>> queryReligionFamilyMembers() async {
    final db = await database; // Get the database instance

    // Define the list of religions you want to filter by
    final List<String> religions = [
      'Buddhism',
      'Hinduism',
      'Islam',
      'Christianity',
      'Other'
    ];

    // Convert the list into a comma-separated string with single quotes for the SQL query
    final String religionsString =
        religions.map((religion) => "'$religion'").join(', ');

    // Query the database for family members whose religion matches any of the specified options
    return await db.rawQuery(
        'SELECT * FROM family_members WHERE religion IN ($religionsString)');
  }

  Future<List<Map<String, dynamic>>> queryNationalityFamilyMembers() async {
    final db = await database; // Get the database instance

    // Define the list of nationalities you want to filter by
    final List<String> nationalities = [
      'Sinhala',
      'Tamil',
      'Muslim',
      'Malay',
      'Burgher',
      'Other'
    ];

    // Convert the list into a comma-separated string with single quotes for the SQL query
    final String nationalitiesString =
        nationalities.map((nationality) => "'$nationality'").join(', ');

    // Query the database for family members whose nationality matches any of the specified options
    return await db.rawQuery(
        'SELECT * FROM family_members WHERE nationality IN ($nationalitiesString)');
  }

  Future<List<Map<String, dynamic>>> queryHigherEducationFamilyMembers() async {
    final db = await database; // Get the database instance

    // Define the list of education qualifications you want to filter by
    final List<String> educationQualifications = [
      'Primary (1-5)',
      'Junior Secondary (6-9)',
      'Senior Secondary (10-11)',
      'O/L passed',
      'Collegiate Level (12-13)',
      'A/L passed',
      'Diploma',
      'Degree',
      'Higher Studies',
      'No Schooling'
    ];

    // Convert the list into a comma-separated string with single quotes for the SQL query
    final String qualificationsString = educationQualifications
        .map((qualification) => "'$qualification'")
        .join(', ');

    // Query the database for family members whose education qualification matches any of the specified levels
    return await db.rawQuery(
        'SELECT * FROM family_members WHERE educationQualification IN ($qualificationsString)');
  }

  Future<Map<String, List<FamilyMember>>> getPeopleBasedOnAgeGroups() async {
    final db = await database;

    // Query all family members
    final List<Map<String, dynamic>> maps = await db.query('family_members');

    // Convert query results into FamilyMember objects
    final List<FamilyMember> members =
        maps.map((map) => FamilyMember.fromMap(map)).toList();

    // Define age groups
    Map<String, List<FamilyMember>> ageGroups = {
      'Infants and Toddlers (0-4 years)': [],
      'Children (5-14 years)': [],
      'Youth (15-24 years)': [],
      'Adults (25-54 years)': [],
      'Older Adults (55-64 years)': [],
      'Seniors (65+ years)': [],
    };

    // Sort family members into age groups
    for (var member in members) {
      if (member.age >= 0 && member.age <= 4) {
        ageGroups['Infants and Toddlers (0-4 years)']!.add(member);
      } else if (member.age >= 5 && member.age <= 14) {
        ageGroups['Children (5-14 years)']!.add(member);
      } else if (member.age >= 15 && member.age <= 24) {
        ageGroups['Youth (15-24 years)']!.add(member);
      } else if (member.age >= 25 && member.age <= 54) {
        ageGroups['Adults (25-54 years)']!.add(member);
      } else if (member.age >= 55 && member.age <= 64) {
        ageGroups['Older Adults (55-64 years)']!.add(member);
      } else if (member.age >= 65) {
        ageGroups['Seniors (65+ years)']!.add(member);
      }
    }

    return ageGroups;
  }

  Future<Map<String, List<FamilyMember>>>
      getPeopleBasedOnAgeGroupsLegally() async {
    final db = await database;

    // Query all family members
    final List<Map<String, dynamic>> maps = await db.query('family_members');

    // Convert query results into FamilyMember objects
    final List<FamilyMember> members =
        maps.map((map) => FamilyMember.fromMap(map)).toList();

    // Define age groups
    Map<String, List<FamilyMember>> ageGroups = {
      'Children (<18 years)': [],
      'Adults (18+ years)': [],
    };

    // Sort family members into the two age groups
    for (var member in members) {
      if (member.age < 18) {
        ageGroups['Children (<18 years)']!.add(member);
      } else {
        ageGroups['Adults (18+ years)']!.add(member);
      }
    }

    return ageGroups;
  }

  // Method to query family members with the jobType as 'Government'
  Future<List<FamilyMember>> queryGovernmentEmployees() async {
    final db = await database;

    // Query the family_members table where jobType is 'Government'
    final List<Map<String, dynamic>> maps = await db.query(
      'family_members',
      where: 'jobType = ?',
      whereArgs: ['Government'],
    );

    // Convert the query result into a list of FamilyMember objects
    return List.generate(maps.length, (i) {
      return FamilyMember.fromMap(maps[i]);
    });
  }

  // Method to query family members with the jobType as 'Private'
  Future<List<FamilyMember>> queryPrivateEmployees() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'family_members',
      where: 'jobType = ?',
      whereArgs: ['Private'],
    );

    return List.generate(maps.length, (i) {
      return FamilyMember.fromMap(maps[i]);
    });
  }

  // Method to query family members with the jobType as 'Semi-Government'
  Future<List<FamilyMember>> querySemiGovernmentEmployees() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'family_members',
      where: 'jobType = ?',
      whereArgs: ['Semi-Government'],
    );

    return List.generate(maps.length, (i) {
      return FamilyMember.fromMap(maps[i]);
    });
  }

  // Method to query family members with the jobType as 'Corporations'
  Future<List<FamilyMember>> queryCorporationEmployees() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'family_members',
      where: 'jobType = ?',
      whereArgs: ['Corporations'],
    );

    return List.generate(maps.length, (i) {
      return FamilyMember.fromMap(maps[i]);
    });
  }

  // Method to query family members with the jobType as 'Forces'
  Future<List<FamilyMember>> queryForcesEmployees() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'family_members',
      where: 'jobType = ?',
      whereArgs: ['Forces'],
    );

    return List.generate(maps.length, (i) {
      return FamilyMember.fromMap(maps[i]);
    });
  }

  // Method to query family members with the jobType as 'Police'
  Future<List<FamilyMember>> queryPoliceEmployees() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'family_members',
      where: 'jobType = ?',
      whereArgs: ['Police'],
    );

    return List.generate(maps.length, (i) {
      return FamilyMember.fromMap(maps[i]);
    });
  }

  // Method to query family members with the jobType as 'Self-Employed (Business)'
  Future<List<FamilyMember>> querySelfEmployedEmployees() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'family_members',
      where: 'jobType = ?',
      whereArgs: ['Self-Employed (Business)'],
    );

    return List.generate(maps.length, (i) {
      return FamilyMember.fromMap(maps[i]);
    });
  }

  // Method to query family members with the jobType as 'No Job'
  Future<List<FamilyMember>> queryNoJobEmployees() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'family_members',
      where: 'jobType = ?',
      whereArgs: ['No Job'],
    );

    return List.generate(maps.length, (i) {
      return FamilyMember.fromMap(maps[i]);
    });
  }

  // Check if household number is unique
  Future<bool> isHouseholdNumberUnique(String householdNumber) async {
    final db = await database;
    final result = await db.query(
      'family_members',
      where: 'householdNumber = ?',
      whereArgs: [householdNumber],
    );
    return result.isEmpty;
  }

  // Check if national ID is unique
  Future<bool> isNationalIdUnique(String nationalId) async {
    final db = await database;
    final result = await db.query(
      'family_members',
      where: 'nationalId = ?',
      whereArgs: [nationalId],
    );
    return result.isEmpty;
  }
}
