# Vehicle Logging System Documentation

This document explains the usage and flow of files involved in the vehicle logging system for the CVMS (Campus Vehicle Management System) mobile application.

## System Overview

The vehicle logging system handles entry and exit scans of vehicles on campus using QR code scanning. It maintains a complete audit trail of vehicle movements with timestamps, user information, and status tracking.

## Core Components

### 1. Data Layer

#### `vehicle_repository.dart`

**Purpose**: Central repository for all vehicle-related database operations.

**Key Methods**:

- `getVehicleById(String id)`: Fetches vehicle data from Firestore using document ID
- `startSession(VehicleModel vehicle, String updatedBy)`: Creates a new vehicle log entry for entry scan
- `endSession(VehicleModel vehicle, String updatedBy)`: Updates existing log entry for exit scan
- `handleEntryScan({required String vehicleDocId, required String updatedBy})`: Complete entry scan workflow
- `handleExitScan({required String vehicleDocId, required String updatedBy})`: Complete exit scan workflow

**Database Operations**:

- **Collection**: `vehicles` - Stores vehicle master data
- **Collection**: `vehicle_logs` - Stores movement history and session data

**Transaction Safety**: Uses Firestore transactions to ensure data consistency when updating both vehicle status and creating log entries.

### 2. Business Logic Layer

#### `vehicle_scan_cubit.dart`

**Purpose**: Manages the state and business logic for vehicle scanning operations.

**Key Methods**:

- `processEntryScan(String vehicleDocId, String updatedBy)`: Handles entry scan workflow
- `processExitScan(String vehicleDocId, String updatedBy)`: Handles exit scan workflow

**State Management**:

- `VehicleScanInitial`: Initial state
- `VehicleScanLoading`: Processing state during database operations
- `VehicleScanSuccess`: Successful scan completion
- `VehicleScanError`: Error state with error message

**Error Handling**: Catches exceptions from repository layer and emits appropriate error states.

#### `qr_scanner_cubit.dart`

**Purpose**: Manages QR scanner UI state and coordinates with vehicle scanning logic.

**Key Methods**:

- `onDetect(BarcodeCapture capture, Future<bool> Function(String) onScanAsync)`: Main detection handler
- `toggleTorch()`: Controls camera flashlight
- `switchCamera()`: Switches between front/rear cameras

**Features**:

- Haptic feedback on QR detection
- Visual feedback with frame color changes (green for success, red for error)
- Sound feedback (success/error sounds)
- Processing state management to prevent multiple simultaneous scans

### 3. Presentation Layer

#### `entrance_scan_page.dart`

**Purpose**: UI page for vehicle entry scanning.

**Key Features**:

- QR scanner interface for entry scans
- Stream-based state listening for real-time feedback
- User authentication integration
- Toast notifications for scan results

**Workflow**:

1. User scans QR code
2. Calls `processEntryScan` with QR data and current user
3. Listens to cubit state changes via stream subscription
4. Returns success/failure result to QR scanner cubit
5. Shows appropriate toast notification

#### `exit_scan_page.dart`

**Purpose**: UI page for vehicle exit scanning.

**Key Features**:

- QR scanner interface for exit scans
- Similar workflow to entrance scan but calls `processExitScan`
- Handles exit-specific validation logic

## Data Flow

### Entry Scan Flow

```
QR Scanner → onDetect() → entrance_scan_page.onScan()
    ↓
VehicleScanCubit.processEntryScan()
    ↓
VehicleRepository.handleEntryScan()
    ↓
1. getVehicleById() - Fetch vehicle data
2. Validate vehicle status (must not be 'inside')
3. startSession() - Create log entry & update vehicle status
    ↓
Return success/failure to UI
    ↓
Show toast notification & play sound
```

### Exit Scan Flow

```
QR Scanner → onDetect() → exit_scan_page.onScan()
    ↓
VehicleScanCubit.processExitScan()
    ↓
VehicleRepository.handleExitScan()
    ↓
1. getVehicleById() - Fetch vehicle data
2. Validate vehicle status (must be 'inside')
3. endSession() - Update log entry & vehicle status
    ↓
Return success/failure to UI
    ↓
Show toast notification & play sound
```

## Database Schema

### Vehicles Collection

```json
{
  "id": "vehicle_document_id",
  "ownerName": "John Doe",
  "plateNumber": "ABC-123",
  "vehicleModel": "Toyota Camry",
  "status": "inside" | "outside"
}
```

### Vehicle Logs Collection

```json
{
  "id": "log_document_id",
  "vehicleId": "vehicle_document_id",
  "ownerName": "John Doe",
  "plateNumber": "ABC-123",
  "vehicleModel": "Toyota Camry",
  "timeIn": "2024-01-15T10:30:00Z",
  "timeOut": "2024-01-15T12:45:00Z" | null,
  "durationMinutes": 135 | null,
  "updatedBy": "Security Guard Name",
  "status": "inside" | "outside"
}
```

## Error Handling

### Common Error Scenarios

1. **Vehicle Not Found**: QR code doesn't match any vehicle in database
2. **Vehicle Already Inside**: Attempting entry scan for vehicle already on campus
3. **Vehicle Not Inside**: Attempting exit scan for vehicle not currently on campus
4. **No Active Session**: Attempting exit scan without corresponding entry scan

### Error Flow

```
Error occurs in Repository → Exception thrown
    ↓
VehicleScanCubit catches exception → Emits VehicleScanError state
    ↓
UI receives error state → Shows error toast
    ↓
QR Scanner Cubit receives false result → Plays error sound & shows red frame
```

## Debug Features

The system includes comprehensive debug logging with emoji prefixes for easy identification:

- 🔍 **Data Fetching**: Vehicle lookup operations
- 🎯 **Business Logic**: Entry/exit scan processing
- 🚀 **Process Start**: Beginning of operations
- ✅ **Success**: Successful operations
- ❌ **Errors**: Failed operations
- 📱 **QR Detection**: Scanner events
- 🔊 **Audio**: Sound feedback
- 🔄 **State Changes**: Cubit state transitions

## Security Considerations

1. **User Authentication**: All scans are attributed to the currently authenticated user
2. **Transaction Safety**: Database operations use Firestore transactions
3. **Input Validation**: QR codes are validated before processing
4. **Status Validation**: Business rules prevent invalid state transitions

## Performance Optimizations

1. **Stream Subscriptions**: Efficient state listening without polling
2. **Transaction Batching**: Multiple database operations in single transaction
3. **State Management**: Prevents duplicate scans during processing
4. **Resource Cleanup**: Proper disposal of scanner controllers and subscriptions

## Usage Examples

### Adding a New Vehicle

```dart
// Vehicle must be added to 'vehicles' collection first
// QR code should contain the vehicle's document ID
```

### Scanning for Entry

```dart
// 1. User opens entrance scan page
// 2. Points camera at vehicle's QR code
// 3. System validates vehicle exists and is not already inside
// 4. Creates log entry with current timestamp
// 5. Updates vehicle status to 'inside'
```

### Scanning for Exit

```dart
// 1. User opens exit scan page
// 2. Points camera at vehicle's QR code
// 3. System validates vehicle exists and is currently inside
// 4. Finds active session and updates with exit time
// 5. Calculates duration and updates vehicle status to 'outside'
```

## ANALOGY

This system provides a complete audit trail of vehicle movements while ensuring data integrity and providing real-time feedback to users.

## Step-by-Step With Analogy

1. Car arrives at the gate.
   Guard uses the scanner screen (QrScannerPage).

2. QR is scanned.
   QrScannerCubit reads the code, vibrates the phone, and says “I got a code” but waits for confirmation.

3. Request sent to messenger.
   EntranceScanPage takes the scanned code and hands it off to VehicleScanCubit.

4. Messenger goes to database clerk.
   VehicleScanCubit calls VehicleRepository.handleEntryScan().

5. Database clerk checks and updates.

Does the car exist?

Is it outside?

If yes → create a new log and mark it inside.

If no → throw an error.

6. Messenger returns with the result.
   VehicleScanCubit emits success or error.

7. Scanner shows feedback.
   QrScannerCubit updates the frame color (green/red), plays a sound, and shows a toast.

## 🏁 In simplest terms

- UI (QrScannerPage) = The camera view.

- QrScannerCubit = Handles camera and immediate feedback.

- EntranceScanPage = Passes the scanned value to vehicle logic and waits for result.

- VehicleScanCubit = Controls state of scanning and calls repo.

- VehicleRepository = Actually does the Firestore updates.
