import 'package:flutter/material.dart';
import 'database_helper.dart'; // Ensure you import your DatabaseHelper
import 'family_member.dart'; // Import your FamilyMember model

class AswasumaFamiliesScreen extends StatefulWidget {
  @override
  _AswasumaFamiliesScreenState createState() => _AswasumaFamiliesScreenState();
}

class _AswasumaFamiliesScreenState extends State<AswasumaFamiliesScreen> {
  Map<String, List<FamilyMember>> groupedAswasumaFamilies = {};

  @override
  void initState() {
    super.initState();
    _fetchAswasumaFamilies();
  }

  Future<void> _fetchAswasumaFamilies() async {
    final dbHelper = DatabaseHelper(); // Instantiate your DatabaseHelper
    final List<Map<String, dynamic>> familyMembersMap =
        await dbHelper.queryAswasumaFamilies(); // Query for Aswasuma families

    final List<FamilyMember> familiesWithAswasuma =
        familyMembersMap.map((map) => FamilyMember.fromMap(map)).toList();

    // Group family members by household number
    groupedAswasumaFamilies.clear(); // Clear previous data
    for (var familyMember in familiesWithAswasuma) {
      if (groupedAswasumaFamilies.containsKey(familyMember.householdNumber)) {
        groupedAswasumaFamilies[familyMember.householdNumber]!
            .add(familyMember);
      } else {
        groupedAswasumaFamilies[familyMember.householdNumber] = [familyMember];
      }
    }

    setState(() {
      // Refresh UI
    });
  }

  String getOrdinal(int number) {
    if (number % 100 >= 11 && number % 100 <= 13) {
      return '${number}th';
    }
    switch (number % 10) {
      case 1:
        return '${number}st';
      case 2:
        return '${number}nd';
      case 3:
        return '${number}rd';
      default:
        return '${number}th';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aswasuma Aid receivers'),
      ),
      body: ListView.builder(
        itemCount: groupedAswasumaFamilies.keys.length,
        itemBuilder: (context, index) {
          String householdNumber =
              groupedAswasumaFamilies.keys.elementAt(index);
          List<FamilyMember> members =
              groupedAswasumaFamilies[householdNumber]!;

          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            child: ExpansionTile(
              title: Text('${index + 1}. Household Number: $householdNumber'),
              subtitle: Text('Members: ${members.length}'),
              children: members.asMap().entries.map((entry) {
                int memberIndex = entry.key + 1;
                FamilyMember familyMember = entry.value;

                return ListTile(
                  title:
                      Text('${getOrdinal(memberIndex)}: ${familyMember.name}'),
                  subtitle: Text('National ID: ${familyMember.nationalId}'),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
