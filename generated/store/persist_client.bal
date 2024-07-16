// AUTO-GENERATED FILE. DO NOT MODIFY.
// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.
import ballerina/jballerina.java;
import ballerina/persist;
import ballerinax/persist.inmemory;

const STUDENT = "students";
final isolated table<Student> key(id) studentsTable = table [];

public isolated client class Client {
    *persist:AbstractPersistClient;

    private final map<inmemory:InMemoryClient> persistClients;

    public isolated function init() returns persist:Error? {
        final map<inmemory:TableMetadata> metadata = {
            [STUDENT] : {
                keyFields: ["id"],
                query: queryStudents,
                queryOne: queryOneStudents
            }
        };
        self.persistClients = {[STUDENT] : check new (metadata.get(STUDENT).cloneReadOnly())};
    }

    isolated resource function get students(StudentTargetType targetType = <>) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "query"
    } external;

    isolated resource function get students/[int id](StudentTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "queryOne"
    } external;

    isolated resource function post students(StudentInsert[] data) returns int[]|persist:Error {
        int[] keys = [];
        foreach StudentInsert value in data {
            lock {
                if studentsTable.hasKey(value.id) {
                    return persist:getAlreadyExistsError("Student", value.id);
                }
                studentsTable.put(value.clone());
            }
            keys.push(value.id);
        }
        return keys;
    }

    isolated resource function put students/[int id](StudentUpdate value) returns Student|persist:Error {
        lock {
            if !studentsTable.hasKey(id) {
                return persist:getNotFoundError("Student", id);
            }
            Student student = studentsTable.get(id);
            foreach var [k, v] in value.clone().entries() {
                student[k] = v;
            }
            studentsTable.put(student);
            return student.clone();
        }
    }

    isolated resource function delete students/[int id]() returns Student|persist:Error {
        lock {
            if !studentsTable.hasKey(id) {
                return persist:getNotFoundError("Student", id);
            }
            return studentsTable.remove(id).clone();
        }
    }

    public isolated function close() returns persist:Error? {
        return ();
    }
}

isolated function queryStudents(string[] fields) returns stream<record {}, persist:Error?> {
    table<Student> key(id) studentsClonedTable;
    lock {
        studentsClonedTable = studentsTable.clone();
    }
    return from record {} 'object in studentsClonedTable
        select persist:filterRecord({
            ...'object
        }, fields);
}

isolated function queryOneStudents(anydata key) returns record {}|persist:NotFoundError {
    table<Student> key(id) studentsClonedTable;
    lock {
        studentsClonedTable = studentsTable.clone();
    }
    from record {} 'object in studentsClonedTable
    where persist:getKey('object, ["id"]) == key
    do {
        return {
            ...'object
        };
    };
    return persist:getNotFoundError("Student", key);
}

