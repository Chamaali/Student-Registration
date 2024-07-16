import student_reg_backend.store;

import ballerina/http;
import ballerina/persist;

final store:Client sClient = check new ();

service / on new http:Listener(9090) {

    resource function post students(store:StudentRequest student) returns int|error {
        store:StudentInsert studentInsert = check student.cloneWithType();
        int[] studentIds = check sClient->/students.post([studentInsert]);
        return studentIds[0];
    }

    resource function get students/[int id]() returns store:Student|error {
        return check sClient->/students/[id];
    }

    resource function get students() returns store:Student[]|error {
        stream<store:Student, persist:Error?> resultStream = sClient->/students;
        return check from store:Student student in resultStream
            select student;
    }

    resource function put students/[int id](store:StudentUpdate student) returns store:Student|error {
        return check sClient->/students/[id].put(student);
    }

    resource function delete students/[int id]() returns store:Student|error {
        return check sClient->/students/[id].delete();
    }
}


