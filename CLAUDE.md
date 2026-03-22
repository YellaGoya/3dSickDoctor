# 3D Sick Doctor

Windows 전용 투명 오버레이 앱. 게임 화면 위에 도트 그리드 + 십자선 패턴을 표시한다.

## Tech Stack

- **Qt 6.8.3** + **QML** + **C++17**
- **CMake 3.16+**, MinGW 64-bit
- Qt 모듈: `Quick`, `Widgets`, `Qt5Compat.GraphicalEffects`
- Windows API: `dwmapi.h` (투명 윈도우), `SetWindowPos` (항상 위)
- 설정 영속화: `QStandardPaths::DocumentsLocation`/3DSickDoctor/configs.json

## Build

```bash
# Qt Creator에서 Felgo SDK Desktop Qt 6.8.3 MinGW 64-bit 키트 사용
# CMake 프로젝트명: threeSickDoctor, 실행파일: app3DSickDoctor
cmake -B build -G Ninja
cmake --build build
```

## Project Structure

```
3DSickDoctor/
  main.cpp           # 진입점, ConfigManager, 시스템 트레이, Windows topmost 타이머
  Main.qml           # 루트 윈도우, 도트/십자선 렌더링, 모든 상태 소유 (SSoT)
  Settings.qml       # 설정 모달 윈도우 (드래그 가능, 페이드 인/아웃)
  DotContent.qml     # 도트 설정 패널 (Enabled, Color, Opacity, Size, Spacing, Padding)
  CrossContent.qml   # 십자선 설정 패널 (Enabled, Color, Opacity, Weight, Length, Radii, Paddings)
  AboutContent.qml   # 앱 정보 패널
  ColorBar.qml       # HSV 색상 선택기 (재사용 컴포넌트, DotContent/CrossContent에서 사용)
  configs.json       # 샘플 설정 파일
  assets/
    Settings.png     # 설정 아이콘 (32x32)
    Sf.ttf           # San Francisco 폰트 (CMakeLists에서 주석 처리됨)
  CMakeLists.txt     # 빌드 설정
```

## Architecture

### State Management (Single Source of Truth)

**Main.qml**이 모든 설정 상태를 소유한다. 하위 컴포넌트는 `root.*` 프로퍼티를 직접 참조한다.

```
Main.qml (root)
├── Dot 프로퍼티: dotEnabled, dotColor, dotOpacity, dotSize, dotSpacing, dotPadding
├── Cross 프로퍼티: crossEnabled, crossColor, crossOpacity, crossWeight, crossLength,
│                   crossInnerRadius, crossOuterRadius, crossVerticalPadding, crossHorizontalPadding
├── 메타: isFirstTime, isLoadDone
└── 계산: cols, rows, offsetX, offsetY (도트 그리드 좌표)
```

### Data Flow

```
[사용자 입력] → DotContent/CrossContent (TextField/ColorBar)
    → root.dotX / root.crossX 프로퍼티 변경
    → onXChanged → handleConfigChanged() → showNeedSave()
    → Save 버튼 클릭 → settings.save 시그널 → saveConfigurations()
    → configManager.save(dataToSave)  [C++ → JSON 파일]
```

### Component Dependencies

```
Main.qml
├── Repeater (도트 그리드) — root.cols * root.rows 개
├── Rectangle x4 (상/하/좌/우 십자선 팔)
├── Item#crossContainer (중앙 십자선, layer.enabled: true)
│   ├── Rectangle (세로 막대)
│   └── Rectangle (가로 막대)
└── Settings (id: settingsWindow)
    ├── Loader → DotContent / CrossContent / AboutContent
    │   ├── DotContent → ColorBar (id: colorBar)
    │   └── CrossContent → ColorBar (id: colorBar)
    └── Toast (toastMessage) + Close 버튼
```

### C++ ↔ QML 연결

- `ConfigManager` 클래스가 `configManager`라는 이름으로 QML context에 등록됨
- `Q_INVOKABLE save(QVariantMap)` → JSON 파일 쓰기
- `Q_INVOKABLE load()` → JSON 파일 읽기 → QVariantMap 반환
- 트레이 메뉴 "Settings" → `QMetaObject::invokeMethod(root, "openSettings")`
- 트레이 메뉴 "Hide pattern" → `window->setVisible()` 토글

## Key Patterns

### Animation Convention

모든 시각적 프로퍼티 변경에 동일한 애니메이션 적용:
```qml
Behavior on <property> {
    NumberAnimation { duration: 250; easing.type: Easing.OutCubic }
}
// 색상은 ColorAnimation 사용
```

**문제점**: Main.qml에 십자선 4개 팔 각각에 동일한 Behavior 블록이 9개씩 반복됨 (총 ~36개). 리팩토링 대상.

### Input Validation Ranges

| 프로퍼티 | 최소 | 최대 | 기본값 |
|---------|------|------|--------|
| dotSize | 0 | 25 | 7 |
| dotSpacing | 20 | 200 | 50 |
| dotPadding | 0 | 200 | 50 |
| dotOpacity | 0.0 | 1.0 | 0.5 |
| crossWeight | 10 | 200 | 30 |
| crossLength | 10 | 200 | 80 |
| crossInnerRadius | 0 | 50 | 8 |
| crossOuterRadius | 0 | 50 | 8 |
| crossH/VPadding | 0 | 200 | 50 |
| crossOpacity | 0.0 | 1.0 | 0.5 |

### ColorBar 양방향 동기화

- `syncColor(hexString)`: 외부 → ColorBar (드래그 중이면 무시)
- `colorChangedByUser(color)` 시그널: ColorBar → 외부 (드래그 중일 때만 발송)
- 흰색/검은색일 때 Hue 값 유실 방지 로직 포함

### 색상 형식

- QML 내부: `#AARRGGBB` (9자리) 또는 `#RRGGBB` (7자리)
- 사용자 표시/저장: `#RRGGBB` (대문자, 7자리)
- 변환: `hexStr.length === 9 ? "#" + hexStr.substring(3) : hexStr`

## Known Issues / Refactoring Opportunities

1. **Behavior 중복**: Main.qml 십자선 4개 팔에 동일한 애니메이션 코드 ~200줄 반복
2. **DotContent/CrossContent 중복**: Enabled 토글, Color 입력, Opacity 입력, ScrollView+커스텀 스크롤바 구조가 거의 동일
3. **ConfigManager가 main.cpp에 인라인**: 별도 .h/.cpp 파일로 분리 가능
4. **font.family: sf.name**: FontLoader(id: sf)가 Main.qml에서 주석 처리되어 있어 Settings/DotContent/CrossContent에서 sf.name 참조 시 경고 가능
5. **100ms topmost 타이머**: 폴링 방식이므로 이벤트 기반으로 개선 여지
6. **configs.json 경로**: 프로젝트 루트와 Documents 폴더에 각각 존재 (루트 것은 샘플)

## Conventions

- 한국어 주석 사용
- 커밋 메시지: `feat:` 접두사, 영문
- QML id 네이밍: camelCase (예: settingsWindow, colorBar, scrollView)
- 색상 상수: 하드코딩된 hex 값 사용 (테마 시스템 없음)
- 디자인 토큰: `#f9f9f9` (배경), `#101010` (텍스트), `#519cff`/`#2378ff` (액센트), `#d0d0d0` (보더)
