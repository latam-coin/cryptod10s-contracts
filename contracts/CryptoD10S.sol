pragma solidity ^0.7.0;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';
import '@openzeppelin/contracts/math/SafeMath.sol';

contract CryptoD10S is ERC20 {
  constructor() ERC20('CryptoD10S', 'D10S') {
    // Total Supply = 10.000.000

    // ICO 1 - 20% = 2.000.000
    _mint(0xE369e09Bf7671d4e6950788E2b80E79B4d961DE7, 2000000);

    // ICO 2 - 10% = 1.000.000
    _mint(0xfa0d377502C7e360Ca83F7aa33bBECf598A075fd, 1000000);

    // CRYPTOD10S NFT APP - 30% = 3.000.000
    _mint(0x656Bf5ED747EDc06c8feC258a8ca591fE1F67Bb6, 3000000);

    // BUSINESS - 20% = 2.000.000
    _mint(0xF933AB8fD1EAAF021F543751b0DfC487683c29cD, 2000000);

    // LICENSES - 5% = 500.000
    _mint(0x3BDD9a3fD8EC10c9306E9feD300B2eD48BeDA801, 500000);

    // CEO 1 - 5% = 500.000
    _mint(0xD7674BeDBAddd991749d12c5F443A13C75af5273, 500000);

    // CEO 2 - 5% = 500.000
    _mint(0x13BE8393248eCB17875ebcFf653fA60743E60B87, 500000);

    // CEO 3 - 5% = 500.000
    _mint(0x17dd771Df78c357891D43439a17EAd51Cc06C5dC, 500000);

    // Decimals = 8
    _setupDecimals(8);
  }
}