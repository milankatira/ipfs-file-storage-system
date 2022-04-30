pragma solidity ^0.5.0;

contract DStorage {
    //TODO Name
    string public name = "DStorage";

    //todo Number of files
    uint public fileCount = 0;

    //todo Mapping fileId=>Struct
    mapping(uint => File) public files;

    //todo Struct
    struct File {
        uint fileId;
        string fileHash;
        uint fileSize;
        string fileType;
        string fileName;
        string fileDescription;
        uint uploadTime;
        address payable uploader;
    }

    //todo Event
    event FileUploaded(
        uint fileId,
        string fileHash,
        uint fileSize,
        string fileType,
        string fileName,
        string fileDescription,
        uint uploadTime,
        address payable uploader
    );

    constructor() public {}

    //todo Upload File function
    function uploadFile(
        string memory _fileHash,
        uint _fileSize,
        string memory _fileType,
        string memory _fileName,
        string memory _fileDescription
    ) public {
        require(bytes(_fileHash).length > 0);
        require(bytes(_fileType).length > 0);
        require(bytes(_fileDescription).length > 0);
        require(bytes(_fileName).length > 0);
        require(msg.sender != address(0));
        require(_fileSize > 0);

        //todo Increment file id
        fileCount++;

        //todo Add File to the contract
        files[fileCount] = File(
            fileCount,
            _fileHash,
            _fileSize,
            _fileType,
            _fileName,
            _fileDescription,
            now,
            msg.sender
        );
        
        //todo Trigger an event
        emit FileUploaded(
            fileCount,
            _fileHash,
            _fileSize,
            _fileType,
            _fileName,
            _fileDescription,
            now,
            msg.sender
        );
    }
}
