/**
 * Copyright (c) 2003, 2010 IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 * Contributors:
 * IBM Corporation - initial API and implementation
 */

part of draw2d.graph;

/**
 * For internal use only. A list of lists.
 * @author hudsonr
 * @since 2.1.2
 */
class RankList extends ListBase<Rank> {
  /**
   * Returns the specified rank.
   * @param rankthe row
   * @return the rank
   */
  Rank operator [](int rank) {
    while (list.length <= rank) list.add(new Rank());
    return list[rank];
  }
}
