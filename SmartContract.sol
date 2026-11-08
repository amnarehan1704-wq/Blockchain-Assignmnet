// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title Campus Lost & Found
/// @notice Students report lost/found items, others claim them, and the
///         original reporter confirms the item was returned. All on-chain.
contract CampusLostFound {
    enum Status { Open, Claimed, Returned }

    struct Item {
        uint256 id;
        address reporter;
        string title;
        string description;
        string location;
        bool isLost;        // true = "I lost this", false = "I found this"
        Status status;
        address claimer;
        uint256 timestamp;
    }

    uint256 private itemCount;
    mapping(uint256 => Item) private items;

    event ItemReported(uint256 indexed id, address indexed reporter, string title, bool isLost);
    event ItemClaimed(uint256 indexed id, address indexed claimer);
    event ItemReturned(uint256 indexed id);

    /// @notice WRITE: report a lost or found item
    function reportItem(
        string memory _title,
        string memory _description,
        string memory _location,
        bool _isLost
    ) public returns (uint256) {
        require(bytes(_title).length > 0, "Title required");

        itemCount++;
        items[itemCount] = Item({
            id: itemCount,
            reporter: msg.sender,
            title: _title,
            description: _description,
            location: _location,
            isLost: _isLost,
            status: Status.Open,
            claimer: address(0),
            timestamp: block.timestamp
        });

        emit ItemReported(itemCount, msg.sender, _title, _isLost);
        return itemCount;
    }

    /// @notice WRITE: someone says "this is mine" (found item) or "I have it" (lost item)
    function claimItem(uint256 _id) public {
        require(_id > 0 && _id <= itemCount, "Item does not exist");
        Item storage it = items[_id];
        require(it.status == Status.Open, "Item is not open");
        require(it.reporter != msg.sender, "Reporter cannot claim own item");

        it.status = Status.Claimed;
        it.claimer = msg.sender;
        emit ItemClaimed(_id, msg.sender);
    }

    /// @notice WRITE: only the reporter confirms the item was handed back
    function markReturned(uint256 _id) public {
        require(_id > 0 && _id <= itemCount, "Item does not exist");
        Item storage it = items[_id];
        require(msg.sender == it.reporter, "Only reporter can confirm");
        require(it.status == Status.Claimed, "Item must be claimed first");

        it.status = Status.Returned;
        emit ItemReturned(_id);
    }

    /// @notice READ: total number of reported items
    function getItemCount() public view returns (uint256) {
        return itemCount;
    }

    /// @notice READ: full details of one item
    function getItem(uint256 _id) public view returns (Item memory) {
        require(_id > 0 && _id <= itemCount, "Item does not exist");
        return items[_id];
    }
}
