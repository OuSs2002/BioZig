from Bio import SeqIO
from Bio.Seq import Seq

def translate_fasta_complete(input_file, table=1):
    """
    Translate complete DNA sequences without stopping at stop codons.
    
    Parameters:
    input_file (str): Path to input FASTA file with DNA sequences
    table (int): Genetic code table number (default=1 for standard code)
    """
    try:
        print("\nTranslating complete sequences:")
        print("-" * 50)
        
        for record in SeqIO.parse(input_file, "fasta"):
            # Adjust sequence length to be divisible by 3 if needed
            seq_length = len(record.seq)
            adjusted_seq = record.seq[:seq_length - (seq_length % 3)]
            
            # Translate without stopping at stop codons
            protein = adjusted_seq.translate(table=table, to_stop=False)
            
            print(f"\nSequence: {record.id}")
            print(f"DNA length: {len(adjusted_seq)} nucleotides")
            print(f"Protein length: {len(protein)} amino acids")
            print("\nProtein sequence:")
            print(protein)
            print("-" * 50)
            
    except FileNotFoundError:
        print(f"Error: Input file '{input_file}' not found")
    except Exception as e:
        print(f"An error occurred: {str(e)}")

# Example usage
if __name__ == "__main__":
    example_input = "/home/mykali/Desktop/BC/sequence.fasta" 
    translate_fasta_complete(example_input)
