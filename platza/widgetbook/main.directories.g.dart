// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:widgetbook/widgetbook.dart' as _widgetbook;

import 'use_cases/atoms/care_type_icon_container_use_case.dart'
    as _asset_platza_widgetbook_use_cases_atoms_care_type_icon_container_use_case;
import 'use_cases/atoms/pixel_art_widget_use_case.dart'
    as _asset_platza_widgetbook_use_cases_atoms_pixel_art_widget_use_case;
import 'use_cases/atoms/pixel_container_use_case.dart'
    as _asset_platza_widgetbook_use_cases_atoms_pixel_container_use_case;
import 'use_cases/atoms/section_header_use_case.dart'
    as _asset_platza_widgetbook_use_cases_atoms_section_header_use_case;
import 'use_cases/atoms/status_badge_use_case.dart'
    as _asset_platza_widgetbook_use_cases_atoms_status_badge_use_case;
import 'use_cases/molecules/care_action_button_use_case.dart'
    as _asset_platza_widgetbook_use_cases_molecules_care_action_button_use_case;
import 'use_cases/molecules/empty_state_use_case.dart'
    as _asset_platza_widgetbook_use_cases_molecules_empty_state_use_case;
import 'use_cases/molecules/link_navigation_card_use_case.dart'
    as _asset_platza_widgetbook_use_cases_molecules_link_navigation_card_use_case;
import 'use_cases/molecules/platza_card_use_case.dart'
    as _asset_platza_widgetbook_use_cases_molecules_platza_card_use_case;
import 'use_cases/molecules/schedule_status_badge_use_case.dart'
    as _asset_platza_widgetbook_use_cases_molecules_schedule_status_badge_use_case;
import 'use_cases/organisms/care_reaction_overlay_use_case.dart'
    as _asset_platza_widgetbook_use_cases_organisms_care_reaction_overlay_use_case;
import 'use_cases/organisms/photo_viewer_dialog_use_case.dart'
    as _asset_platza_widgetbook_use_cases_organisms_photo_viewer_dialog_use_case;
import 'use_cases/organisms/shell_scaffold_use_case.dart'
    as _asset_platza_widgetbook_use_cases_organisms_shell_scaffold_use_case;

final directories = <_widgetbook.WidgetbookNode>[
  _widgetbook.WidgetbookFolder(
    name: 'presentation',
    children: [
      _widgetbook.WidgetbookFolder(
        name: 'widgets',
        children: [
          _widgetbook.WidgetbookFolder(
            name: 'atoms',
            children: [
              _widgetbook.WidgetbookComponent(
                name: 'CareTypeIconContainer',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder:
                        _asset_platza_widgetbook_use_cases_atoms_care_type_icon_container_use_case
                            .careTypeIconContainerDefault,
                  )
                ],
              ),
              _widgetbook.WidgetbookComponent(
                name: 'PixelArtWidget',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder:
                        _asset_platza_widgetbook_use_cases_atoms_pixel_art_widget_use_case
                            .pixelArtWidgetDefault,
                  )
                ],
              ),
              _widgetbook.WidgetbookComponent(
                name: 'PixelContainer',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Sizes',
                    builder:
                        _asset_platza_widgetbook_use_cases_atoms_pixel_container_use_case
                            .pixelContainerSizes,
                  )
                ],
              ),
              _widgetbook.WidgetbookComponent(
                name: 'SectionHeader',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder:
                        _asset_platza_widgetbook_use_cases_atoms_section_header_use_case
                            .sectionHeaderDefault,
                  ),
                  _widgetbook.WidgetbookUseCase(
                    name: 'With action',
                    builder:
                        _asset_platza_widgetbook_use_cases_atoms_section_header_use_case
                            .sectionHeaderWithAction,
                  ),
                ],
              ),
              _widgetbook.WidgetbookComponent(
                name: 'StatusBadge',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Chip',
                    builder:
                        _asset_platza_widgetbook_use_cases_atoms_status_badge_use_case
                            .statusBadgeChip,
                  ),
                  _widgetbook.WidgetbookUseCase(
                    name: 'Dot',
                    builder:
                        _asset_platza_widgetbook_use_cases_atoms_status_badge_use_case
                            .statusBadgeDot,
                  ),
                  _widgetbook.WidgetbookUseCase(
                    name: 'Icon',
                    builder:
                        _asset_platza_widgetbook_use_cases_atoms_status_badge_use_case
                            .statusBadgeIcon,
                  ),
                ],
              ),
            ],
          ),
          _widgetbook.WidgetbookFolder(
            name: 'molecules',
            children: [
              _widgetbook.WidgetbookComponent(
                name: 'CareActionButton',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'All types',
                    builder:
                        _asset_platza_widgetbook_use_cases_molecules_care_action_button_use_case
                            .careActionButtonAllTypes,
                  ),
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder:
                        _asset_platza_widgetbook_use_cases_molecules_care_action_button_use_case
                            .careActionButtonDefault,
                  ),
                ],
              ),
              _widgetbook.WidgetbookComponent(
                name: 'EmptyState',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder:
                        _asset_platza_widgetbook_use_cases_molecules_empty_state_use_case
                            .emptyStateDefault,
                  ),
                  _widgetbook.WidgetbookUseCase(
                    name: 'With action',
                    builder:
                        _asset_platza_widgetbook_use_cases_molecules_empty_state_use_case
                            .emptyStateWithAction,
                  ),
                ],
              ),
              _widgetbook.WidgetbookComponent(
                name: 'LinkNavigationCard',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder:
                        _asset_platza_widgetbook_use_cases_molecules_link_navigation_card_use_case
                            .linkNavigationCardDefault,
                  ),
                  _widgetbook.WidgetbookUseCase(
                    name: 'Without subtitle',
                    builder:
                        _asset_platza_widgetbook_use_cases_molecules_link_navigation_card_use_case
                            .linkNavigationCardNoSubtitle,
                  ),
                ],
              ),
              _widgetbook.WidgetbookComponent(
                name: 'PlatzaCard',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'List tile',
                    builder:
                        _asset_platza_widgetbook_use_cases_molecules_platza_card_use_case
                            .platzaCardListTile,
                  ),
                  _widgetbook.WidgetbookUseCase(
                    name: 'Text content',
                    builder:
                        _asset_platza_widgetbook_use_cases_molecules_platza_card_use_case
                            .platzaCardText,
                  ),
                ],
              ),
              _widgetbook.WidgetbookComponent(
                name: 'ScheduleStatusBadge',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder:
                        _asset_platza_widgetbook_use_cases_molecules_schedule_status_badge_use_case
                            .scheduleStatusBadgeDefault,
                  ),
                  _widgetbook.WidgetbookUseCase(
                    name: 'Later',
                    builder:
                        _asset_platza_widgetbook_use_cases_molecules_schedule_status_badge_use_case
                            .scheduleStatusBadgeLater,
                  ),
                  _widgetbook.WidgetbookUseCase(
                    name: 'Overdue',
                    builder:
                        _asset_platza_widgetbook_use_cases_molecules_schedule_status_badge_use_case
                            .scheduleStatusBadgeOverdue,
                  ),
                  _widgetbook.WidgetbookUseCase(
                    name: 'Soon',
                    builder:
                        _asset_platza_widgetbook_use_cases_molecules_schedule_status_badge_use_case
                            .scheduleStatusBadgeSoon,
                  ),
                  _widgetbook.WidgetbookUseCase(
                    name: 'Today',
                    builder:
                        _asset_platza_widgetbook_use_cases_molecules_schedule_status_badge_use_case
                            .scheduleStatusBadgeToday,
                  ),
                ],
              ),
            ],
          ),
          _widgetbook.WidgetbookFolder(
            name: 'organisms',
            children: [
              _widgetbook.WidgetbookComponent(
                name: 'CareReactionOverlay',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Playground',
                    builder:
                        _asset_platza_widgetbook_use_cases_organisms_care_reaction_overlay_use_case
                            .careReactionOverlayPlayground,
                  )
                ],
              ),
              _widgetbook.WidgetbookComponent(
                name: 'PhotoViewerDialog',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Launcher (error placeholder)',
                    builder:
                        _asset_platza_widgetbook_use_cases_organisms_photo_viewer_dialog_use_case
                            .photoViewerDialogLauncher,
                  )
                ],
              ),
            ],
          ),
        ],
      )
    ],
  ),
  _widgetbook.WidgetbookFolder(
    name: 'widgetbook',
    children: [
      _widgetbook.WidgetbookFolder(
        name: 'use_cases',
        children: [
          _widgetbook.WidgetbookFolder(
            name: 'organisms',
            children: [
              _widgetbook.WidgetbookComponent(
                name: 'ShellScaffoldPreview',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Preview',
                    builder:
                        _asset_platza_widgetbook_use_cases_organisms_shell_scaffold_use_case
                            .shellScaffoldPreview,
                  )
                ],
              )
            ],
          )
        ],
      )
    ],
  ),
];
