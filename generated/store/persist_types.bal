// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.

public type Student record {|
    readonly int id;
    string name;
    string address;
    string phone;
|};


public type StudentRequest record {|
    int id;
    string name;
    string address;
    string phone;
|};

public type StudentOptionalized record {|
    int id?;
    string name?;
    string address?;
    string phone?;
|};

public type StudentTargetType typedesc<StudentOptionalized>;

public type StudentInsert Student;

public type StudentUpdate record {|
    string name?;
    string address?;
    string phone?;
|};

