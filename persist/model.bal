import ballerina/persist as _;

public type Student record {|
    readonly int id;
    string name;
    string address;
    string phone;

|};
