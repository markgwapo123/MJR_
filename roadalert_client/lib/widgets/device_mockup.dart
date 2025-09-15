import 'package:flutter/material.dart';

class DeviceMockupWidget extends StatelessWidget {
  const DeviceMockupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Laptop screen
          Container(
            width: 200,
            height: 130,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[700]!, width: 2),
            ),
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  // Top bar
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 8),
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Colors.yellow,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Content area with map-like design
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        children: [
                          // Header
                          Container(
                            height: 12,
                            color: Colors.grey[200],
                          ),
                          const SizedBox(height: 2),
                          // Map area
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Stack(
                                children: [
                                  // Map lines
                                  Positioned(
                                    top: 20,
                                    left: 10,
                                    child: Container(
                                      width: 40,
                                      height: 2,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                  Positioned(
                                    top: 35,
                                    left: 15,
                                    child: Container(
                                      width: 30,
                                      height: 2,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                  // Location pins
                                  Positioned(
                                    top: 15,
                                    left: 25,
                                    child: Container(
                                      width: 4,
                                      height: 4,
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 30,
                                    left: 35,
                                    child: Container(
                                      width: 4,
                                      height: 4,
                                      decoration: const BoxDecoration(
                                        color: Colors.orange,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Laptop base
          Positioned(
            bottom: 0,
            child: Container(
              width: 220,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
            ),
          ),
          // Phone
          Positioned(
            bottom: 20,
            right: 40,
            child: Container(
              width: 40,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[700]!, width: 1),
              ),
              child: Container(
                margin: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    // Status bar
                    Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
                      ),
                    ),
                    // Content
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        child: Column(
                          children: [
                            Container(
                              height: 6,
                              color: Colors.grey[200],
                            ),
                            const SizedBox(height: 1),
                            Expanded(
                              child: Container(
                                color: Colors.blue[50],
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 8,
                                      left: 5,
                                      child: Container(
                                        width: 2,
                                        height: 2,
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
