# Reusable Info Section Architecture

This architecture provides a clean, maintainable, and reusable solution for displaying information sections in your CVMS mobile app.

## Architecture Overview

### 1. Data Models (`info_section_data.dart`)

- **`InfoSectionData`**: Base class for label-value pairs
- **`StudentInfoData`**: Specific model for student information
- **`AddressData`**: Specific model for address information
- **`VehicleDetailsData`**: Specific model for vehicle details

Each specific model has a `toInfoSectionData()` method that converts the model to a list of `InfoSectionData` objects.

### 2. Reusable Widget (`custom_vehicle_section.dart`)

- **`CustomInfoSection`**: Generic widget that accepts:
  - `categoryName`: The title of the section
  - `icon`: Icon to display next to the title
  - `data`: List of `InfoSectionData` objects to display

### 3. Factory Pattern (`info_section_factory.dart`)

- **`InfoSectionFactory`**: Provides static methods to create pre-configured sections
- Reduces boilerplate code
- Ensures consistency across the app

## Usage Examples

### Basic Usage

```dart
// Create data
final studentInfo = StudentInfoData(
  schoolId: 'KC-22-A-00266',
  fullname: 'Juan Dela Cruz',
  gender: 'Male',
  course: 'BSCS',
  yearLevel: 'Year',
  block: 'A',
  contact: '0943242421',
);

// Create section using factory
final section = InfoSectionFactory.createStudentInfoSection(studentInfo);
```

### Custom Section

```dart
// Create custom data
final customData = [
  InfoSectionData(label: 'Custom Field 1', value: 'Value 1'),
  InfoSectionData(label: 'Custom Field 2', value: 'Value 2'),
];

// Create custom section
final section = InfoSectionFactory.createCustomSection(
  categoryName: 'Custom Information',
  icon: PhosphorIconsBold.gear,
  data: customData,
);
```

### Direct Widget Usage

```dart
CustomInfoSection(
  categoryName: 'Student information',
  icon: PhosphorIconsBold.user,
  data: studentInfo.toInfoSectionData(),
)
```

## Benefits

1. **Reusability**: Single widget handles all information sections
2. **Type Safety**: Strongly typed data models prevent errors
3. **Maintainability**: Changes to styling affect all sections consistently
4. **Extensibility**: Easy to add new section types
5. **Clean Code**: Factory pattern reduces boilerplate
6. **Consistency**: Ensures uniform appearance across the app

## Adding New Section Types

1. Create a new data model class extending the pattern:

```dart
class NewSectionData {
  final String field1;
  final String field2;

  const NewSectionData({
    required this.field1,
    required this.field2,
  });

  List<InfoSectionData> toInfoSectionData() {
    return [
      InfoSectionData(label: 'Field 1', value: field1),
      InfoSectionData(label: 'Field 2', value: field2),
    ];
  }
}
```

2. Add a factory method:

```dart
static CustomInfoSection createNewSection(NewSectionData data) {
  return CustomInfoSection(
    categoryName: 'New Section',
    icon: PhosphorIconsBold.yourIcon,
    data: data.toInfoSectionData(),
  );
}
```

## Integration with State Management

This architecture works seamlessly with state management solutions like Bloc, Riverpod, or Provider. Simply pass the data from your state to the factory methods.

```dart
// In your BlocBuilder or Consumer
BlocBuilder<YourCubit, YourState>(
  builder: (context, state) {
    return InfoSectionFactory.createStudentInfoSection(state.studentInfo);
  },
)
```
