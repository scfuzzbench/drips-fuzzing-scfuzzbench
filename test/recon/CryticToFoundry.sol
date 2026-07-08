// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {CryticTester} from "./CryticTester.sol";

// forge test --match-contract CryticToFoundry -vv
//
// The suite names its property handlers `test*`/`invariant*`, which Foundry
// would otherwise pick up as standalone unit tests / invariant predicates.
// Routing the invariant campaign at a deployed CryticTester keeps the
// handlers stateful-fuzz-only, identical to how Echidna and Medusa exercise
// them. Time advancement between calls comes from [invariant] max_time_delay
// / max_block_delay in foundry.toml (mirroring the Echidna/Medusa configs).
contract CryticToFoundry is Test {
    CryticTester tester;

    function setUp() public {
        tester = new CryticTester();

        targetContract(address(tester));
        targetSender(address(0x10000));
        targetSender(address(0x20000));
        targetSender(address(0x30000));
        targetSender(address(0x40000));
    }

    function invariant_noop() public returns (bool) {
        return true;
    }
}
