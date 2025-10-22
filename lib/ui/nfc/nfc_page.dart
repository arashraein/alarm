import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:provider/provider.dart';
import 'package:nfc_manager_ndef/nfc_manager_ndef.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../data/providers/navigation_provider.dart';
import '../shared/themes.dart';

class NfcPage extends StatefulWidget {
  const NfcPage({super.key});

  @override
  State<NfcPage> createState() => _NfcPageState();
}

class _NfcPageState extends State<NfcPage> {
  String? _tagId;
  int counter = 0;

  Future<void> _startNfcScanning() async {
    final NfcAvailability availability =
        await NfcManager.instance.checkAvailability();

    if (availability != NfcAvailability.enabled) {
      debugPrint('NFC may not be supported or may be temporarily disabled.');
      return;
    }

    await NfcManager.instance.startSession(
      pollingOptions: {NfcPollingOption.iso14443},
      onDiscovered: (NfcTag tag) async {
        final Ndef? ndef = Ndef.from(tag);

        if (ndef == null) {
          debugPrint('This tag is not compatible with NDEF.');
          return;
        }
        setState(() {
          _tagId = ndef.toString();
          counter++;
        });
        Provider.of<NavigationProvider>(context, listen: false).nfcTagId =
            _tagId;
        await NfcManager.instance
            .stopSession(alertMessageIos: 'Tag scanned successfully!');
      },
    );
  }

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('NFC Scanner'),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_tagId != null) Text('Scanned NFC Tag ID: $_tagId'),
              Text('Number of Scanned: $counter'),
              const SizedBox(height: 20),
              CupertinoButton.filled(
                onPressed: _startNfcScanning,
                child: const Text('Start Scanning'),
              ),
              const SizedBox(height: 20),
              ShadIconButton(
                iconSize: 32,
                width: 50,
                height: 50,
                gradient: const LinearGradient(colors: [
                  destructiveColor,
                  destructiveColor2,
                ]),
                shadows: [
                  BoxShadow(
                    color: destructiveColor.withValues(alpha: .4),
                    spreadRadius: 4,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
                icon: const Icon(
                  CupertinoIcons.pause_circle,
                ),
                onPressed: () async {
                  await NfcManager.instance
                      .stopSession(errorMessageIos: 'force');
                },
              )
            ],
          ),
        ),
      );
}
