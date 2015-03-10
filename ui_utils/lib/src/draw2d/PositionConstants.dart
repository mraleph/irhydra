/**
 * Copyright (c) 2000, 2010 IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 * Contributors:
 * IBM Corporation - initial API and implementation
 */


part of draw2d.graph;

/**
 * Constants representing cardinal directions and relative positions. Some of
 * these constants can be grouped as follows:
 * <TABLE border="1" cellpadding="5" cellspacing="0">
 * <TBODY>
 * <TR>
 * <TD>LEFT, CENTER, RIGHT</TD>
 * <TD>Used to describe horizontal position.</TD>
 * </TR>
 * <TR>
 * <TD>TOP, MIDDLE, BOTTOM</TD>
 * <TD>Used to describe vertical position.</TD>
 * </TR>
 * <TR>
 * <TD>NORTH, SOUTH, EAST, WEST</TD>
 * <TD>Used to describe the four positions relative to an object's center point.
 * May also be used when describing which direction an object is facing.<BR>
 * NOTE: If you have a use for all four of these possibilities, do not use TOP,
 * BOTTOM, RIGHT, LEFT in place of NORTH, SOUTH, EAST, WEST.</TD>
 * </TR>
 * </TBODY>
 * </TABLE>
 */
class PositionConstants {
  /**
   * None
   */
  static const int NONE = 0;
  /**
   * Left
   */
  static const int LEFT = 1;
  /**
   * Center (Horizontal)
   */
  static const int CENTER = 2;
  /**
   * Right
   */
  static const int RIGHT = 4;
  /**
   * Bit-wise OR of LEFT, CENTER, and RIGHT
   */
  static const int LEFT_CENTER_RIGHT = LEFT | CENTER;
  /**
   * Used to signify left alignment regardless of orientation (i.e., LTR or
   * RTL)
   */
  static const int ALWAYS_LEFT = 64;
  /**
   * Used to signify right alignment regardless of orientation (i.e., LTR or
   * RTL)
   */
  static const int ALWAYS_RIGHT = 128;
  /**
   * Top
   */
  static const int TOP = 8;
  /**
   * Middle (Vertical)
   */
  static const int MIDDLE = 16;
  /**
   * Bottom
   */
  static const int BOTTOM = 32;
  /**
   * Bit-wise OR of TOP, MIDDLE, and BOTTOM
   */
  static const int TOP_MIDDLE_BOTTOM = TOP | MIDDLE;
  /**
   * North
   */
  static const int NORTH = 1;
  /**
   * South
   */
  static const int SOUTH = 4;
  /**
   * West
   */
  static const int WEST = 8;
  /**
   * East
   */
  static const int EAST = 16;
  /**
   * A constant indicating horizontal direction
   */
  static const int HORIZONTAL = 64;
  /**
   * A constant indicating vertical direction
   */
  static const int VERTICAL = 128;
  /**
   * North-East: a bit-wise OR of {@link #NORTH} and {@link #EAST}
   */
  static const int NORTH_EAST = NORTH | EAST;
  /**
   * North-West: a bit-wise OR of {@link #NORTH} and {@link #WEST}
   */
  static const int NORTH_WEST = NORTH | WEST;
  /**
   * South-East: a bit-wise OR of {@link #SOUTH} and {@link #EAST}
   */
  static const int SOUTH_EAST = SOUTH | EAST;
  /**
   * South-West: a bit-wise OR of {@link #SOUTH} and {@link #WEST}
   */
  static const int SOUTH_WEST = SOUTH | WEST;
  /**
   * North-South: a bit-wise OR of {@link #NORTH} and {@link #SOUTH}
   */
  static const int NORTH_SOUTH = NORTH | SOUTH;
  /**
   * East-West: a bit-wise OR of {@link #EAST} and {@link #WEST}
   */
  static const int EAST_WEST = EAST | WEST;
  /**
   * North-South-East-West: a bit-wise OR of all 4 directions.
   */
  static const int NSEW = NORTH_SOUTH | EAST_WEST;
}
