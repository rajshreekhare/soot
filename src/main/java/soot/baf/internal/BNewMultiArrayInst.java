package soot.baf.internal;

/*-
 * #%L
 * Soot - a J*va Optimization Framework
 * %%
 * Copyright (C) 1999 Patrick Lam, Patrick Pominville and Raja Vallee-Rai
 * %%
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, either version 2.1 of the
 * License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Lesser Public License for more details.
 * 
 * You should have received a copy of the GNU General Lesser Public
 * License along with this program.  If not, see
 * <http://www.gnu.org/licenses/lgpl-2.1.html>.
 * #L%
 */

import soot.ArrayType;
import soot.UnitPrinter;
import soot.baf.InstSwitch;
import soot.baf.NewMultiArrayInst;
import soot.util.Switch;

public class BNewMultiArrayInst extends AbstractInst implements NewMultiArrayInst {
  int dimensionCount;

  ArrayType baseType;

  public BNewMultiArrayInst(ArrayType opType, int dimensionCount) {
    this.dimensionCount = dimensionCount;
    baseType = opType;
  }

  public int getInCount() {
    return dimensionCount;
  }

  public int getOutCount() {
    return 1;
  }

  public int getInMachineCount() {
    return dimensionCount;
  }

  public int getOutMachineCount() {
    return 1;
  }

  public Object clone() {
    return new BNewMultiArrayInst(getBaseType(), getDimensionCount());
  }

  final public String getName() {
    return "newmultiarray";
  }

  final String getParameters() {
    return " " + dimensionCount;
  }

  protected void getParameters(UnitPrinter up) {
    up.literal(" ");
    up.literal(new Integer(dimensionCount).toString());
  }

  public ArrayType getBaseType() {
    return baseType;
  }

  public void setBaseType(ArrayType type) {
    baseType = type;
  }

  public int getDimensionCount() {
    return dimensionCount;
  }

  public void setDimensionCount(int x) {
    x = dimensionCount;
  }

  public void apply(Switch sw) {
    ((InstSwitch) sw).caseNewMultiArrayInst(this);
  }

  public boolean containsNewExpr() {
    return true;
  }
}
