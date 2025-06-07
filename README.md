# Decentralized Maritime Fisheries Management System

A comprehensive blockchain-based system for managing commercial fishing operations, built on the Stacks blockchain using Clarity smart contracts.

## Overview

This system provides a decentralized solution for managing maritime fisheries through five interconnected smart contracts that handle vessel verification, catch reporting, quota management, sustainability monitoring, and market coordination.

## System Architecture

### Core Contracts

1. **Vessel Verification Contract** (`vessel-verification.clar`)
    - Registers and verifies commercial fishing vessels
    - Manages vessel licenses and operational status
    - Tracks vessel ownership and registration details

2. **Catch Reporting Contract** (`catch-reporting.clar`)
    - Records fishing catches with detailed information
    - Links catches to specific vessels and locations
    - Provides verification mechanisms for reported catches

3. **Quota Management Contract** (`quota-management.clar`)
    - Manages fishing quotas for different species
    - Allocates quotas to individual vessels
    - Tracks quota usage and prevents overfishing

4. **Sustainability Monitoring Contract** (`sustainability-monitoring.clar`)
    - Monitors environmental impact of fishing activities
    - Tracks bycatch and habitat impact scores
    - Manages species conservation status

5. **Market Coordination Contract** (`market-coordination.clar`)
    - Facilitates fish market sales and pricing
    - Creates marketplace listings for caught fish
    - Tracks price history and market trends

## Features

### Vessel Management
- Secure vessel registration with unique IDs
- License validation and tracking
- Vessel status management (active/inactive)
- Owner verification and authorization

### Catch Tracking
- Comprehensive catch reporting system
- Species-specific catch recording
- Location and date tracking
- Verification workflow for reported catches

### Quota Control
- Species-based quota allocation
- Real-time quota usage tracking
- Automated quota compliance checking
- Flexible quota period management

### Sustainability Monitoring
- Environmental impact assessment
- Bycatch reporting and tracking
- Species conservation status management
- Compliance scoring system

### Market Operations
- Decentralized fish marketplace
- Price discovery and history tracking
- Secure transaction processing
- Listing expiration management

## Getting Started

### Prerequisites
- Stacks blockchain node or access to testnet
- Clarity CLI tools
- Node.js and npm for testing

### Installation

1. Clone the repository:
   \`\`\`bash
   git clone <repository-url>
   cd maritime-fisheries-system
   \`\`\`

2. Install dependencies:
   \`\`\`bash
   npm install
   \`\`\`

3. Run tests:
   \`\`\`bash
   npm test
   \`\`\`

### Deployment

Deploy contracts to Stacks testnet:

\`\`\`bash
# Deploy vessel verification contract
clarinet deploy --testnet contracts/vessel-verification.clar

# Deploy other contracts in order
clarinet deploy --testnet contracts/catch-reporting.clar
clarinet deploy --testnet contracts/quota-management.clar
clarinet deploy --testnet contracts/sustainability-monitoring.clar
clarinet deploy --testnet contracts/market-coordination.clar
\`\`\`

## Usage Examples

### Register a Vessel
\`\`\`clarity
(contract-call? .vessel-verification register-vessel "FL-12345" "Sea Explorer" "Trawler")
\`\`\`

### Submit Catch Report
\`\`\`clarity
(contract-call? .catch-reporting submit-catch-report u1 "Tuna" u500 "Atlantic Ocean")
\`\`\`

### Set Species Quota
\`\`\`clarity
(contract-call? .quota-management set-species-quota "Tuna" u10000 u365)
\`\`\`

### Create Market Listing
\`\`\`clarity
(contract-call? .market-coordination create-listing u1 "Tuna" u100 u50 u100 u1)
\`\`\`

## Testing

The system includes comprehensive tests using Vitest:

\`\`\`bash
# Run all tests
npm test

# Run specific test file
npm test vessel-verification.test.js
\`\`\`

## Contract Interactions

### Error Codes
- 100-199: Vessel Verification errors
- 200-299: Catch Reporting errors
- 300-399: Quota Management errors
- 400-499: Sustainability Monitoring errors
- 500-599: Market Coordination errors

### Data Structures

#### Vessel Data
- vessel-id: Unique identifier
- owner: Principal address
- license-number: Government license
- vessel-name: Display name
- registration-date: Block height
- is-active: Status flag
- vessel-type: Category of vessel

#### Catch Report
- report-id: Unique identifier
- vessel-id: Associated vessel
- fish-species: Type of fish
- catch-weight: Amount caught
- catch-location: Fishing location
- catch-date: Block height
- verified: Verification status

## Security Considerations

- All vessel operations require owner authorization
- Quota limits are enforced at the contract level
- Market transactions include expiration mechanisms
- Sustainability compliance is automatically calculated

## Contributing

1. Fork the repository
2. Create a feature branch
3. Add tests for new functionality
4. Ensure all tests pass
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For questions or support, please open an issue in the repository or contact the development team.
\`\`\`

Finally, let's create the PR details file:
