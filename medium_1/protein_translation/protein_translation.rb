class InvalidCodonError < StandardError;
end

class Translation
  def self.of_codon(codon)
    Codon.new(codon).to_amino
  end

  def self.of_rna(strand)
    sequence = []
    strand.chars.each_slice(3) do |slice|
      codon = slice.join
      amino = of_codon(codon)
      return sequence if amino == 'STOP'
      sequence << amino
    end
    sequence
  end
end

class Codon
  AMINO_CHART = { 'Methionine'    => %w(AUG),
                  'Phenylalanine' => %w(UUU UUC),
                  'Leucine'       => %w(UUA UUG),
                  'Serine'        => %w(UCU UCC UCA UCG),
                  'Tyrosine'      => %w(UAU UAC),
                  'Cysteine'      => %w(UGU UGC),
                  'Tryptophan'    => %w(UGG),
                  'STOP'          => %w(UAA UAG UGA) }.freeze

  def initialize(codon)
    @codon = codon
  end

  def to_amino
    AMINO_CHART.each do |amino, codons|
      return amino if codons.include? @codon
    end
    raise InvalidCodonError
  end
end
